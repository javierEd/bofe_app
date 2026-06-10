import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/account_button.dart';
import '../components/screen_title.dart';
import '../constants.dart';
import '../graphql/queries/boards.graphql.dart';
import '../graphql/queries/current_user_boards.graphql.dart';
import '../session_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  int currentIndex = SessionManager.hasToken ? 0 : 1;

  @override
  Widget build(BuildContext context) {
    final textHome = context.l10n.home;

    return ScreenTitle(
      title: textHome,
      child: Scaffold(
        appBar: AppBar(
          title: Row(spacing: 12, children: [Image.asset('assets/icon.png', height: 32), Text('Bofe')]),
          actions: [
            if (SessionManager.hasToken)
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: IconButton.outlined(
                  tooltip: context.l10n.newBoard,
                  icon: Icon(Icons.add),
                  onPressed: () => context.goNamed(routeNameNewBoard),
                ),
              ),
            Padding(padding: EdgeInsets.only(right: 12), child: AccountButton()),
          ],
        ),
        body: [_Home(), _Explore()][currentIndex],
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
              label: textHome,
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore_rounded),
              label: context.l10n.explore,
            ),
          ],
        ),
      ),
    );
  }
}

class _Explore extends StatefulWidget {
  const _Explore();

  @override
  State<_Explore> createState() => _ExploreState();
}

class _ExploreState extends State<_Explore> {
  String? _endCursor;
  bool _hasNextPage = false;
  FetchMore<Query$Boards>? _fetchMore;

  Future<void> _onScrollAtBottom() async {
    await _fetchMore?.call(
      FetchMoreOptions$Query$Boards(
        variables: Variables$Query$Boards(after: _endCursor),
        updateQuery: (previousResultData, fetchMoreResultData) {
          if (fetchMoreResultData == null || fetchMoreResultData['boards']['nodes'].length == 0) {
            return previousResultData;
          }

          fetchMoreResultData['boards']['nodes'] = [
            ...previousResultData?['boards']['nodes'],
            ...fetchMoreResultData['boards']['nodes']
                .where(
                  (node) =>
                      previousResultData?['boards']['nodes'].map((node1) => node1['id']).contains(node['id']) != true,
                )
                .toList(),
          ];

          return fetchMoreResultData;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteScrollView(
      hasMore: _hasNextPage,
      onScrollAtBottom: _onScrollAtBottom,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.explore, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Query$Boards$Widget(
            options: Options$Query$Boards(variables: Variables$Query$Boards(first: 12)),
            builder: (result, {fetchMore, refetch}) {
              _fetchMore ??= fetchMore;

              return QueryResultBuilder(
                result: result,
                buildIf: (data) => data?.boards.nodes.isNotEmpty == true,
                refetch: refetch,
                builder: (data) {
                  final boards = data.boards;

                  _endCursor = boards.pageInfo.endCursor;
                  _hasNextPage = boards.pageInfo.hasNextPage;

                  return BoardsGridView(boards: boards.nodes);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  String? _endCursor;
  bool _hasNextPage = false;
  FetchMore<Query$CurrentUserBoards>? _fetchMore;

  Future<void> _onScrollAtBottom() async {
    await _fetchMore?.call(
      FetchMoreOptions$Query$CurrentUserBoards(
        variables: Variables$Query$CurrentUserBoards(after: _endCursor),
        updateQuery: (previousResultData, fetchMoreResultData) {
          if (fetchMoreResultData == null || fetchMoreResultData['currentUser']['boards']['nodes'].length == 0) {
            return previousResultData;
          }

          fetchMoreResultData['currentUser']['boards']['nodes'] = [
            ...previousResultData?['currentUser']['boards']['nodes'],
            ...fetchMoreResultData['currentUser']['boards']['nodes']
                .where(
                  (node) =>
                      previousResultData?['currentUser']['boards']['nodes']
                          .map((node1) => node1['id'])
                          .contains(node['id']) !=
                      true,
                )
                .toList(),
          ];

          return fetchMoreResultData;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (SessionManager.hasToken) {
      return InfiniteScrollView(
        hasMore: _hasNextPage,
        onScrollAtBottom: _onScrollAtBottom,
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.myBoards, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Query$CurrentUserBoards$Widget(
              options: Options$Query$CurrentUserBoards(variables: Variables$Query$CurrentUserBoards(first: 12)),
              builder: (result, {fetchMore, refetch}) {
                _fetchMore ??= fetchMore;

                return QueryResultBuilder(
                  result: result,
                  buildIf: (data) => data?.currentUser?.boards.nodes.isNotEmpty == true,
                  refetch: refetch,
                  builder: (data) {
                    final boards = data.currentUser!.boards;

                    _endCursor = boards.pageInfo.endCursor;
                    _hasNextPage = boards.pageInfo.hasNextPage;

                    return BoardsGridView(boards: boards.nodes);
                  },
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: SizedBox(
          width: 480,
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.youMustBeLoggedInToViewYourBoards),

              Column(
                spacing: 8,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.router.goToLogin(),
                      icon: const Icon(Icons.login_rounded),
                      label: Text(context.l10n.login),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.router.goToRegister(),
                      icon: const Icon(Icons.person_add_rounded),
                      label: Text(context.l10n.register),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
