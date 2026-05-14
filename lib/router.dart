import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/new_board_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/register_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/show_board_screen.dart';
import 'screens/show_user_screen.dart';
import 'session.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

String? _requireBearer(BuildContext context, GoRouterState state) {
  if (!Session.hasBearer) {
    return '/login';
  }
  return null;
}

String? _requireNoBearer(BuildContext context, GoRouterState state) {
  if (Session.hasBearer) {
    return '/';
  }
  return null;
}

extension GoRouterExt on GoRouter {
  static GoRouter setup() => GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => const NotFoundScreen(),
    observers: [routeObserver],
    routes: [
      GoRoute(
        name: routeNameHome,
        path: '/',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            name: routeNameNewBoard,
            path: 'boards/new',
            redirect: _requireBearer,
            builder: (context, state) => NewBoardScreen(),
          ),
          GoRoute(
            name: routeNameShowBoard,
            path: 'boards/:$keySlug',
            builder: (context, state) {
              final slug = state.pathParameters[keySlug]!;
              return ShowBoardScreen(key: ValueKey(slug), slug: slug);
            },
          ),
          GoRoute(name: routeNameLogin, path: 'login', builder: (context, state) => LoginScreen()),
          GoRoute(name: routeNameSettings, path: 'settings', builder: (context, state) => SettingsScreen()),
          GoRoute(
            name: routeNameRegister,
            path: 'register',
            redirect: _requireNoBearer,
            builder: (context, state) => RegisterScreen(),
          ),
          GoRoute(
            name: routeNameShowUser,
            path: 'users/:$keyUsername',
            builder: (context, state) {
              final username = state.pathParameters[keyUsername]!;
              return ShowUserScreen(key: ValueKey(username), username: username);
            },
            routes: [
              GoRoute(
                name: routeNameShowUserBoard,
                path: 'boards/:$keySlug',
                builder: (context, state) {
                  final username = state.pathParameters[keyUsername]!;
                  final slug = state.pathParameters[keySlug]!;
                  return ShowBoardScreen(key: ValueKey(slug), username: username, slug: slug);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
