import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:restart_app/restart_app.dart';

import 'build_context.dart';
import 'constants.dart';
import 'graphql/fragments/session_fragment.graphql.dart';
import 'graphql/mutations/create_session.graphql.dart';
import 'graphql/mutations/finish_session.graphql.dart';
import 'graphql/mutations/refresh_session.graphql.dart';
import 'graphql/queries/current_user.graphql.dart';
import 'graphql/schema.graphql.dart';
import 'graphql_client.dart';

class SessionsManager {
  static final _storage = FlutterSecureStorage();
  static Fragment$SessionFragment? _currentSession;

  static Fragment$SessionFragment? get current => _currentSession;

  static String? get bearer {
    if (token != null) {
      return 'Bearer $token';
    }

    return null;
  }

  static bool get hasToken => token != null;

  static String? get token => _currentSession?.token;

  static Future<void> _deleteCurrentSession() async {
    if (_currentSession != null) {
      final sessions = await readSessions();

      sessions._remove(_currentSession!);

      await _writeSessions(sessions);
    }
  }

  static Future<Fragment$SessionFragment?> _readCurrentSession() async {
    return (await readSessions()).current;
  }

  static Future<void> _writeSession(Fragment$SessionFragment value) async {
    final sessions = await readSessions();

    sessions._setCurrent(value);

    await _writeSessions(sessions);
  }

  static Future<void> _writeSessions(SessionsData value) async {
    _currentSession = value.current;

    await _storage.write(key: keySessions, value: value.toString());
  }

  static Future<QueryResult<Mutation$CreateSession>> attemptToLogin({
    required String usernameOrEmail,
    required String password,
  }) async {
    final graphQLClient = getGraphQLClient(includeToken: false);
    final result = await graphQLClient.mutate$CreateSession(
      Options$Mutation$CreateSession(
        variables: Variables$Mutation$CreateSession(
          params: Input$SessionParams(usernameOrEmail: usernameOrEmail, password: password),
        ),
      ),
    );

    final session = result.parsedData?.createSession;

    if (session != null) {
      await _writeSession(session);

      graphQLClient.cache.store.reset();

      await Restart.restartApp();
    }

    return result;
  }

  static Future<QueryResult<Mutation$FinishSession>> attemptToLogout(BuildContext context) async {
    final graphQLClient = context.graphQLClient;
    final result = await graphQLClient.mutate$FinishSession();

    if (result.parsedData?.finishSession == true) {
      await _deleteCurrentSession();

      graphQLClient.cache.store.reset();

      await Restart.restartApp();
    }

    return result;
  }

  static Future<void> attemptToRefresh() async {
    final yesterday = DateTime.now().subtract(Duration(days: 1));

    if (_currentSession == null || (_currentSession!.refreshedAt ?? _currentSession!.createdAt).isAfter(yesterday)) {
      return;
    }

    final graphQLClient = getGraphQLClient();
    final result = await graphQLClient.mutate$RefreshSession();
    final session = result.parsedData?.refreshSession;

    if (session != null) {
      await _writeSession(session);
    }
  }

  static Future<Query$CurrentUser$currentUser?>? getUser() async {
    if (!hasToken) {
      return null;
    }

    final graphQLClient = getGraphQLClient();
    final result = await graphQLClient.query$CurrentUser();

    return result.parsedData?.currentUser;
  }

  /// Restore or delete session when there is an unauthorized response.
  static Future<void> onUnauthorized() async {
    // Restart app if session has changed on another instance.
    if (_currentSession?.token != (await _readCurrentSession())?.token) {
      await Restart.restartApp();

      return;
    }

    // Delete invalid session and restart app.
    if (hasToken) {
      await _deleteCurrentSession();
      await Restart.restartApp();
    }
  }

  static Future<void> init() async {
    _currentSession = await _readCurrentSession();
  }

  static Future<SessionsData> readSessions() async {
    final value = await _storage.read(key: keySessions);

    if (value != null) {
      return SessionsData.fromString(value);
    }

    return SessionsData(list: []);
  }

  static Future<void> switchSession(Fragment$SessionFragment session) async {
    await _writeSession(session);

    final graphQLClient = getGraphQLClient();
    graphQLClient.cache.store.reset();

    await Restart.restartApp();
  }
}

class SessionsData {
  SessionsData({this._currentUserId, required this._list});

  String? _currentUserId;
  List<Fragment$SessionFragment> _list;

  factory SessionsData.fromString(String value) {
    final Map<String, dynamic> sessions = jsonDecode(value);
    final currentUserId = sessions[keyCurrentUserId];
    final list =
        sessions[keyList]?.map<Fragment$SessionFragment>((item) => Fragment$SessionFragment.fromJson(item)).toList() ??
        [];

    return SessionsData(currentUserId: currentUserId, list: list);
  }

  Fragment$SessionFragment? get current {
    if (_currentUserId != null) {
      return _list.where((item) => item.user.id == _currentUserId).firstOrNull;
    }

    return null;
  }

  List<Fragment$SessionFragment> get list {
    final now = DateTime.now();

    return _list.where((item) => item.expiresAt.isAfter(now)).toList();
  }

  void _setCurrent(Fragment$SessionFragment session) {
    final index = _list.indexWhere((item) => item.user.id == session.user.id);

    if (index > -1) {
      _list[index] = session;
    } else {
      _list.add(session);
    }

    _currentUserId = session.user.id;
  }

  void _remove(Fragment$SessionFragment session) {
    _list.removeWhere((item) => item.user.id == session.user.id);

    if (_currentUserId == session.user.id) {
      _currentUserId = _list.firstOrNull?.user.id;
    }
  }

  @override
  String toString() => jsonEncode(
    {keyCurrentUserId: _currentUserId, keyList: _list.map((item) => item.toJson()).toList()},
    toEncodable: (value) {
      if (value is Uri) {
        return value.toString();
      }

      return value;
    },
  );
}
