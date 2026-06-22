import 'package:bofe/components/user_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/card_item.dart';
import '../components/screen_title.dart';
import '../constants.dart';
import '../graphql/queries/activities.graphql.dart';
import '../graphql/queries/boards.graphql.dart';
import '../graphql/queries/current_user_boards.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../sessions_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static bool showEmailConfirmationDialog = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  int currentIndex = SessionsManager.hasToken ? 0 : 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (HomeScreen.showEmailConfirmationDialog) {
        showEmailConfirmationDialog(context, barrierDismissible: false).then((_) {
          HomeScreen.showEmailConfirmationDialog = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textHome = context.l10n.home;

    return ScreenTitle(
      title: textHome,
      child: Scaffold(
        appBar: AppBar(
          title: Row(spacing: 12, children: [Image.asset('assets/icon.png', height: 32), Text('Bofe')]),
          actions: [
            if (SessionsManager.hasToken)
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
        body: [_Home(), _Explore(), _Feed()][currentIndex],
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
            NavigationDestination(
              icon: Icon(Icons.rss_feed_outlined),
              selectedIcon: Icon(Icons.rss_feed_rounded),
              label: context.l10n.feed,
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

class _Feed extends StatefulWidget {
  const _Feed();

  @override
  State<_Feed> createState() => _FeedState();
}

class _FeedState extends State<_Feed> {
  String? _endCursor;
  bool _hasNextPage = false;
  FetchMore<Query$Activities>? _fetchMore;

  Future<void> _onScrollAtBottom() async {
    await _fetchMore?.call(
      FetchMoreOptions$Query$Activities(
        variables: Variables$Query$Activities(after: _endCursor),
        updateQuery: (previousResultData, fetchMoreResultData) {
          if (fetchMoreResultData == null || fetchMoreResultData['activities']['nodes'].length == 0) {
            return previousResultData;
          }

          fetchMoreResultData['activities']['nodes'] = [
            ...previousResultData?['activities']['nodes'],
            ...fetchMoreResultData['activities']['nodes']
                .where(
                  (node) =>
                      previousResultData?['activities']['nodes'].map((node1) => node1['id']).contains(node['id']) !=
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
    return InfiniteScrollView(
      hasMore: _hasNextPage,
      onScrollAtBottom: _onScrollAtBottom,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.feed, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Query$Activities$Widget(
            options: Options$Query$Activities(variables: Variables$Query$Activities(first: 12)),
            builder: (result, {fetchMore, refetch}) {
              _fetchMore ??= fetchMore;

              return QueryResultBuilder(
                result: result,
                buildIf: (data) => data?.activities.nodes.isNotEmpty == true,
                refetch: refetch,
                builder: (data) {
                  final activities = data.activities;

                  _endCursor = activities.pageInfo.endCursor;
                  _hasNextPage = activities.pageInfo.hasNextPage;

                  return Center(
                    child: Column(
                      spacing: 8,
                      children: activities.nodes.map((activity) {
                        String actionText = '';

                        switch (activity.action) {
                          case Enum$ActivityAction.CREATE_BOARD:
                            actionText = context.l10n.hasCreatedABoard;
                            break;
                          case Enum$ActivityAction.UPDATE_BOARD:
                            actionText = context.l10n.hasModifiedABoard;
                            break;
                          case Enum$ActivityAction.CREATE_CARD:
                            actionText = context.l10n.hasAddedACardOn;
                            break;
                          case Enum$ActivityAction.UPDATE_CARD:
                            actionText = context.l10n.hasModifiedACardOn;
                            break;
                          case Enum$ActivityAction.UPDATE_CARD_LIST || Enum$ActivityAction.UPDATE_CARD_POSITION:
                            actionText = context.l10n.hasMovedACardOn;
                            break;
                          case Enum$ActivityAction.DELETE_CARD:
                            actionText = context.l10n.hasDeletedACardOn;
                            break;
                          case Enum$ActivityAction.CREATE_LIST:
                            actionText = context.l10n.hasAddedAListOn;
                            break;
                          case Enum$ActivityAction.UPDATE_LIST || Enum$ActivityAction.UPDATE_LIST_POSITION:
                            actionText = context.l10n.hasModifiedAListOn;
                            break;
                          case Enum$ActivityAction.DELETE_LIST:
                            actionText = context.l10n.hasDeletedAListOn;
                            break;
                          default:
                            break;
                        }

                        return Container(
                          width: 640,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: borderRadius,
                          ),
                          child: Column(
                            spacing: 12,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 12,
                                children: [
                                  UserItem(user: activity.user, onTap: () => context.router.pushToUser(activity.user)),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 12,
                                        children: [
                                          Flexible(
                                            child: Text(actionText, overflow: TextOverflow.ellipsis, maxLines: 1),
                                          ),
                                          if (![
                                            Enum$ActivityAction.CREATE_BOARD,
                                            Enum$ActivityAction.UPDATE_BOARD,
                                          ].contains(activity.action))
                                            Flexible(
                                              child: InkWell(
                                                onTap: () => context.router.pushToBoard(activity.board),
                                                child: Text(
                                                  activity.board.name,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Timeago(
                                        date: activity.createdAt,
                                        locale: context.locale.toString(),
                                        builder: (context, timeAgo) => Text(timeAgo, style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (activity.cardData != null)
                                CardItem(
                                  card: activity.cardData!,
                                  showPopupMenu: false,
                                  onTap: () {
                                    context.router.pushToBoard(activity.board);
                                    context.router.pushToCard(activity.cardData!);
                                  },
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
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
    if (SessionsManager.hasToken) {
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

              Column(spacing: 8, children: [LoginButton(), RegisterButton()]),
            ],
          ),
        ),
      );
    }
  }
}
