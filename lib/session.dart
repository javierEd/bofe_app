import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:restart_app/restart_app.dart';

import 'constants.dart';
import 'graphql/mutations/create_session.graphql.dart';
import 'graphql/mutations/finish_session.graphql.dart';
import 'graphql/schema.graphql.dart';
import 'graphql_client.dart';

class Session {
  static final _storage = FlutterSecureStorage();
  static _SessionData? _data;

  static String? get bearer {
    final token = _data?.token;

    if (token == null) {
      return null;
    }

    return 'Bearer $token';
  }

  static bool get hasBearer => _data != null;

  static Future<_SessionData?> _decode(String value) async {
    var data = _SessionData.fromMap(jsonDecode(value));

    return data;
  }

  static Future<void> _delete() async {
    await _storage.delete(key: keySession);
  }

  static Future<_SessionData?> _read() async {
    final value = await _storage.read(key: keySession);

    if (value == null) {
      return null;
    }

    return await _decode(value);
  }

  static Future<void> _write({required String token, required DateTime expiresAt, required DateTime createdAt}) async {
    await _storage.write(
      key: keySession,
      value: jsonEncode(_SessionData(token: token, expiresAt: expiresAt, createdAt: createdAt).toMap()),
    );
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
      await _write(token: session.token, expiresAt: session.expiresAt, createdAt: session.createdAt);

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

  /// Restore or delete session when there is an unauthorized response.
  static Future<void> onUnauthorized() async {
    // Restart app if session has changed on another instance.
    if (_data?.token != (await _read())?.token) {
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
    _data = await _read();

    _storage.registerListener(
      key: keySession,
      listener: (value) async {
        if (value == null) {
          _data = null;

          return;
        }

        _data = await _decode(value);
      },
    );
  }
}

class _SessionData {
  _SessionData({required this.token, required this.expiresAt, required this.createdAt});

  final String token;
  final DateTime expiresAt;
  final DateTime createdAt;

  static _SessionData fromMap(Map<String, dynamic> map) {
    return _SessionData(
      token: map['token'],
      expiresAt: DateTime.parse(map['expiresAt']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  bool needsRefresh() {
    return createdAt.add(Duration(days: 1)).isBefore(DateTime.now()) ||
        expiresAt.difference(DateTime.now()).inHours < 1;
  }

  Map<String, String> toMap() {
    return {'token': token, 'expiresAt': expiresAt.toIso8601String(), 'createdAt': createdAt.toIso8601String()};
  }
}
