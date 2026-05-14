import 'dart:convert';

import 'package:boards/graphql/fragments/session_fragment.graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:restart_app/restart_app.dart';

import 'constants.dart';
import 'graphql/mutations/create_session.graphql.dart';
import 'graphql/mutations/finish_session.graphql.dart';
import 'graphql/mutations/refresh_session.graphql.dart';
import 'graphql/schema.graphql.dart';
import 'graphql_client.dart';

class SessionManager {
  static final _storage = FlutterSecureStorage();
  static Fragment$SessionFragment? _session;

  static String? get bearer {
    if (_session == null) {
      return null;
    }

    return 'Bearer ${_session?.token}';
  }

  static bool get hasBearer => _session != null;

  static Fragment$SessionFragment _decode(String value) {
    return Fragment$SessionFragment.fromJson(jsonDecode(value));
  }

  static Future<void> _delete() async {
    await _storage.delete(key: keySession);
  }

  static Future<Fragment$SessionFragment?> _read() async {
    final value = await _storage.read(key: keySession);

    if (value == null) {
      return null;
    }

    return _decode(value);
  }

  static Future<void> _write(Fragment$SessionFragment value) async {
    await _storage.write(key: keySession, value: jsonEncode(value.toJson()));
  }

  static Future<QueryResult<Mutation$CreateSession>> attemptToLogin(
    BuildContext context, {
    required String usernameOrEmail,
    required String password,
  }) async {
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$CreateSession(
      Options$Mutation$CreateSession(
        variables: Variables$Mutation$CreateSession(
          params: Input$SessionParams(usernameOrEmail: usernameOrEmail, password: password),
        ),
      ),
    );

    final session = result.parsedData?.createSession;

    if (session != null) {
      await _write(session);

      await Restart.restartApp();
    }

    return result;
  }

  static Future<QueryResult<Mutation$FinishSession>> attemptToLogout(BuildContext context) async {
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$FinishSession();

    if (result.parsedData?.finishSession == true) {
      await _delete();

      await Restart.restartApp();
    }

    return result;
  }

  static Future<void> attemptToRefresh(GraphQLClient graphQLClient) async {
    final now = DateTime.now();

    if (_session == null ||
        (now.isBefore(_session!.createdAt.add(Duration(days: 1))) &&
            now.isBefore(_session!.expiresAt.subtract(Duration(hours: 1))))) {
      return;
    }

    final result = await graphQLClient.mutate$RefreshSession();
    final session = result.parsedData?.refreshSession;

    if (session != null) {
      await _write(session);
    }
  }

  /// Restore or delete session when there is an unauthorized response.
  static Future<void> onUnauthorized() async {
    // Restart app if session has changed on another instance.
    if (_session?.token != (await _read())?.token) {
      await Restart.restartApp();

      return;
    }

    // Delete invalid session and restart app.
    if (hasBearer) {
      await _delete();
      await Restart.restartApp();
    }
  }

  static Future<void> init() async {
    _session = await _read();

    _storage.registerListener(
      key: keySession,
      listener: (value) async {
        if (value == null) {
          _session = null;

          return;
        }

        _session = _decode(value);
      },
    );
  }
}
