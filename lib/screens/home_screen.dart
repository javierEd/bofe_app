import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/account_button.dart';
import '../components/board_item.dart';
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
  Future<QueryResult<Query$CurrentUserBoards>?> Function()? _refetch;

  Widget _getMyBoards(BuildContext context) {
    return Query$CurrentUserBoards$Widget(
      options: Options$Query$CurrentUserBoards(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Query$CurrentUserBoards(first: 12),
      ),
      builder: (result, {fetchMore, refetch}) {
        _refetch ??= refetch;

        final user = result.parsedData?.currentUser;

        return Column(
          spacing: 12,
          children: [
            Text('My Boards', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: user?.boards.nodes.length ?? 0,
              itemBuilder: (context, index) {
                final board = user?.boards.nodes[index];

                return BoardItem(
                  board: board!,
                  onTap: () => context.goNamed(routeNameShowBoard, pathParameters: {keySlug: board.slug}),
                );
              },
            ),
          ],
        );
      },
    );
  }

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
          title: Text('Home'),
          actions: [
            SessionManager.hasBearer
                ? Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: IconButton.outlined(
                      tooltip: 'New board',
                      icon: Icon(Icons.add),
                      onPressed: () => context.goNamed(routeNameNewBoard),
                    ),
                  )
                : SizedBox(),
            Padding(padding: EdgeInsets.only(right: 12), child: AccountButton()),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: SessionManager.hasBearer ? _getMyBoards(context) : SizedBox(),
        ),
      ),
    );
  }
}
