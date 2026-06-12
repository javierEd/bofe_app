import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'components/board_context.dart';
import 'constants.dart';
import 'graphql/fragments/board_fragment.graphql.dart';
import 'graphql/fragments/card_fragment.graphql.dart';
import 'graphql/fragments/user_fragment.graphql.dart';
import 'screens/card_dialog_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/labels_dialog_screen.dart';
import 'screens/members_dialog_screen.dart';
import 'screens/board_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/new_board_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/register_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/settings/email_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/user_screen.dart';
import 'session_manager.dart';
import 'value_keys.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

String? _requireToken(BuildContext context, GoRouterState state) {
  if (!SessionManager.hasToken) {
    return '/login';
  }
  return null;
}

String? _requireNoToken(BuildContext context, GoRouterState state) {
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
          path: 'new',
          redirect: _requireToken,
          builder: (context, state) => NewBoardScreen(),
        ),
        GoRoute(
          name: routeNameLogin,
          path: 'login',
          redirect: _requireNoToken,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          name: routeNameSettings,
          path: 'settings',
          builder: (context, state) => SettingsScreen(),
          routes: [
            GoRoute(
              name: routeNameEditProfile,
              path: 'edit-profile',
              redirect: _requireToken,
              builder: (context, state) => EditProfileScreen(),
            ),
            GoRoute(
              name: routeNameSettingsEmail,
              path: 'email',
              redirect: _requireToken,
              builder: (context, state) => EmailScreen(),
            ),
            GoRoute(
              name: routeNameChangePassword,
              path: 'change-password',
              redirect: _requireToken,
              builder: (context, state) => ChangePasswordScreen(),
            ),
          ],
        ),
        GoRoute(
          name: routeNameRegister,
          path: 'register',
          redirect: _requireNoToken,
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          name: routeNameResetPassword,
          path: 'reset-password',
          redirect: _requireNoToken,
          builder: (context, state) => ResetPasswordScreen(),
        ),
        GoRoute(
          name: routeNameUser,
          path: ':$keyUsername',
          builder: (context, state) {
            final username = state.pathParameters[keyUsername]!;
            return UserScreen(key: ValueKeys.user(username), username: username);
          },
        ),
        GoRoute(
          name: routeNameBoard,
          path: ':$keyUsername/:$keySlug',
          builder: (context, state) {
            final username = state.pathParameters[keyUsername]!;
            final slug = state.pathParameters[keySlug]!;
            return BoardScreen(key: ValueKeys.board(username, slug), username: username, slug: slug);
          },
          routes: [
            GoRoute(
              name: routeNameCard,
              path: 'cards/:id',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final id = state.pathParameters[keyId]!;
                return BoardContextDialogPage(
                  pathParameters: state.pathParameters,
                  builder: (board) => CardDialogScreen(key: ValueKeys.card(id), board: board, id: id),
                );
              },
            ),
            GoRoute(
              name: routeNameLabels,
              path: 'labels',
              pageBuilder: (context, state) {
                final username = state.pathParameters[keyUsername]!;
                final slug = state.pathParameters[keySlug]!;
                return BoardContextDialogPage(
                  pathParameters: state.pathParameters,
                  builder: (board) => LabelsDialogScreen(key: ValueKeys.labels(username, slug), board: board),
                );
              },
            ),
            GoRoute(
              name: routeNameMembers,
              path: 'members',
              pageBuilder: (context, state) {
                final username = state.pathParameters[keyUsername]!;
                final slug = state.pathParameters[keySlug]!;
                return BoardContextDialogPage(
                  pathParameters: state.pathParameters,
                  builder: (board) => MembersDialogScreen(key: ValueKeys.members(username, slug), board: board),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

class AppRouter {
  AppRouter(this.context);

  final BuildContext context;

  void goToBoard(Fragment$BoardFragment board) =>
      context.goNamed(routeNameBoard, pathParameters: {keyUsername: board.user.username, keySlug: board.slug});

  void goToChangePassword() => context.goNamed(routeNameChangePassword);

  void goToEditProfile() => context.goNamed(routeNameEditProfile);

  void goToSettingsEmail() => context.goNamed(routeNameSettingsEmail);

  void goToHome() => context.goNamed(routeNameHome);

  void goToLabels(Fragment$BoardFragment board) =>
      context.goNamed(routeNameLabels, pathParameters: {keyUsername: board.user.username, keySlug: board.slug});

  void goToLogin() => context.goNamed(routeNameLogin);

  void goToRegister() => context.goNamed(routeNameRegister);

  void goToResetPassword() => context.goNamed(routeNameResetPassword);

  void goToUser(Fragment$UserFragment user) =>
      context.goNamed(routeNameUser, pathParameters: {keyUsername: user.username});

  void pushToBoard(Fragment$BoardFragment board) =>
      context.pushNamed(routeNameBoard, pathParameters: {keyUsername: board.user.username, keySlug: board.slug});

  void pushToCard(Fragment$CardFragment card) => context.pushNamed(
    routeNameCard,
    pathParameters: {keyUsername: card.board.user.username, keySlug: card.board.slug, keyId: card.id},
  );

  void pushToMembers(Fragment$BoardFragment board) =>
      context.pushNamed(routeNameMembers, pathParameters: {keyUsername: board.user.username, keySlug: board.slug});

  void pushToUser(Fragment$UserFragment user) =>
      context.pushNamed(routeNameUser, pathParameters: {keyUsername: user.username});
}
