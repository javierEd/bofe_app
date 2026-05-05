import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'constants.dart';
import 'screens/home_screen.dart';
import 'screens/not_found_screen.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

extension GoRouterExt on GoRouter {
  static GoRouter setup() => GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => const NotFoundScreen(),
    observers: [routeObserver],
    routes: [GoRoute(name: routeNameHome, path: '/', builder: (context, state) => HomeScreen())],
  );
}
