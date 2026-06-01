import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'components/dialog_page.dart';
import 'constants.dart';
import 'graphql/fragments/board_fragment.graphql.dart';
import 'graphql/fragments/card_fragment.graphql.dart';
import 'graphql/fragments/list_fragment.graphql.dart';
import 'screens/card_dialog_screen.dart';
import 'screens/board_members_screen.dart';
import 'screens/board_screen.dart';
import 'screens/edit_card_dialog_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/new_board_screen.dart';
import 'screens/new_card_dialog_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/register_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/show_user_screen.dart';
import 'session_manager.dart';
import 'value_keys.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

String? _requireBearer(BuildContext context, GoRouterState state) {
  if (!SessionManager.hasToken) {
    return '/login';
  }
  return null;
}

String? _requireNoBearer(BuildContext context, GoRouterState state) {
  if (SessionManager.hasToken) {
    return '/';
  }
  return null;
}

GoRouter getGoRouter() => GoRouter(
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
          name: routeNameBoard,
          path: 'boards/:$keySlug',
          builder: (context, state) {
            final slug = state.pathParameters[keySlug]!;
            return BoardScreen(key: ValueKeys.board(slug), slug: slug);
          },
          routes: [
            GoRoute(
              name: routeNameNewCard,
              path: 'cards/new',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final boardSlug = state.pathParameters[keySlug]!;
                final extra = state.extra as NewCardDialogExtra?;
                return DialogPage(
                  barrierDismissible: false,
                  builder: (_) => NewCardDialogScreen(boardSlug: boardSlug, extra: extra),
                );
              },
            ),
            GoRoute(
              name: routeNameCard,
              path: 'cards/:id',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final boardSlug = state.pathParameters[keySlug]!;
                final id = state.pathParameters[keyId]!;
                return DialogPage(
                  barrierDismissible: false,
                  builder: (_) => CardDialogScreen(key: ValueKeys.card(id), boardSlug: boardSlug, id: id),
                );
              },
            ),
            GoRoute(
              name: routeNameEditCard,
              path: 'cards/:id/edit',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final boardSlug = state.pathParameters[keySlug]!;
                final id = state.pathParameters[keyId]!;
                return DialogPage(
                  barrierDismissible: false,
                  builder: (_) => EditCardDialogScreen(key: ValueKeys.editCard(id), boardSlug: boardSlug, id: id),
                );
              },
            ),
            GoRoute(
              name: routeNameBoardMembers,
              path: 'members',
              builder: (context, state) {
                final slug = state.pathParameters[keySlug]!;
                return BoardMembersScreen(key: ValueKey(slug), slug: slug);
              },
            ),
          ],
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
        ),
      ],
    ),
  ],
);

class AppRouter {
  AppRouter(this.context);

  final BuildContext context;

  void goToBoard(Fragment$BoardFragment board) =>
      context.goNamed(routeNameBoard, pathParameters: {keySlug: board.slug});

  void goToCard(Fragment$CardFragment card) =>
      context.goNamed(routeNameCard, pathParameters: {keySlug: card.board.slug, keyId: card.id});

  void goToEditCard(Fragment$CardFragment card) =>
      context.goNamed(routeNameEditCard, pathParameters: {keySlug: card.board.slug, keyId: card.id});

  void goToLogin() => context.goNamed(routeNameLogin);

  void goToNewCard(Fragment$BoardFragment board, Fragment$ListFragment list) => context.goNamed(
    routeNameNewCard,
    pathParameters: {keySlug: board.slug},
    extra: NewCardDialogExtra(list: list),
  );

  void goToRegister() => context.goNamed(routeNameRegister);
}
