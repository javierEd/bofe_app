import 'package:bofe/preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'constants.dart';
import 'graphql_client.dart';
import 'router.dart';
import 'session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await Preferences.init();
  await SessionManager.init();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  final graphQLClient = getGraphQLClient();
  final goRouter = getGoRouter();

  await SessionManager.attemptToRefresh(graphQLClient);

  runApp(App(graphQLClient: graphQLClient, goRouter: goRouter));
}

class MobileLikeScrollBehavior extends MaterialScrollBehavior {
  const MobileLikeScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class App extends StatelessWidget {
  App({super.key, required this.graphQLClient, required this.goRouter});

  final GraphQLClient graphQLClient;
  final GoRouter goRouter;

  final _roundedRectangleBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

  ThemeData _getThemeData(Brightness brightness) => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colorSeed, brightness: brightness),
    useMaterial3: true,
    dialogTheme: DialogThemeData(shape: _roundedRectangleBorder),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        backgroundColor: colorSeed,
        shape: _roundedRectangleBorder,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        shape: _roundedRectangleBorder,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        iconAlignment: IconAlignment.start,
        padding: const EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        shape: _roundedRectangleBorder,
      ),
    ),
    chipTheme: ChipThemeData(
      shape: _roundedRectangleBorder,
      labelPadding: const EdgeInsets.all(4),
      side: BorderSide(color: colorChip),
      brightness: Brightness.dark,
      selectedColor: colorChip,
      backgroundColor: Colors.transparent,
      checkmarkColor: Colors.black,
      deleteIconColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: WidgetStateColor.resolveWith((state) {
          return state.contains(WidgetState.selected) ? Colors.black : colorChip;
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(graphQLClient),
      child: Preferences.themeModeListenableBuilder(
        builder: (context, themeMode) => MaterialApp.router(
          title: 'Bofe',
          scrollBehavior: const MobileLikeScrollBehavior(),
          themeMode: themeMode,
          theme: _getThemeData(Brightness.light),
          darkTheme: _getThemeData(Brightness.dark),
          routerConfig: goRouter,
        ),
      ),
    );
  }
}
