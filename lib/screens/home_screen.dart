import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/account_button.dart';
import '../components/explore_page.dart';
import '../components/home_page.dart';
import '../components/screen_title.dart';
import '../constants.dart';
import '../graphql/queries/current_user_boards.graphql.dart';
import '../router.dart';
import '../session_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  int currentIndex = SessionManager.hasToken ? 0 : 1;
  Future<QueryResult<Query$CurrentUserBoards>?> Function()? _refetch;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentRoute = ModalRoute.of(context);

    if (currentRoute != null) {
      routeObserver.subscribe(this, currentRoute);
    }
  }

  @override
  void didPopNext() {
    _refetch?.call();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTitle(
      title: 'Home',
      child: Scaffold(
        appBar: AppBar(
          title: Row(spacing: 12, children: [Image.asset('assets/icon.png', height: 32), Text('Bofe')]),
          actions: [
            if (SessionManager.hasToken)
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: IconButton.outlined(
                  tooltip: 'New board',
                  icon: Icon(Icons.add),
                  onPressed: () => context.goNamed(routeNameNewBoard),
                ),
              ),
            Padding(padding: EdgeInsets.only(right: 12), child: AccountButton()),
          ],
        ),
        body: [HomePage(), ExplorePage()][currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
          ],
        ),
      ),
    );
  }
}
