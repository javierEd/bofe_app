import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/boards_grid_view.dart';
import '../components/infinite_scroll_view.dart';
import '../components/query_result_builder.dart';
import '../components/screen_title.dart';
import '../components/user_item.dart';
import '../constants.dart';
import '../graphql/queries/user.graphql.dart';
import '../graphql/queries/user_boards.graphql.dart';
import '../screens/not_found_screen.dart';

class ShowUserScreen extends StatefulWidget {
  const ShowUserScreen({super.key, required this.username});

  final String username;

  @override
  State<ShowUserScreen> createState() => _ShowUserScreenState();
}

class _ShowUserScreenState extends State<ShowUserScreen> {
  String? _endCursor;
  bool _hasNextPage = false;
  FetchMore<Query$UserBoards>? _fetchMore;

  Future<void> _onScrollAtBottom() async {
    await _fetchMore?.call(
      FetchMoreOptions$Query$UserBoards(
        variables: Variables$Query$UserBoards(username: widget.username, after: _endCursor, first: 12),
        updateQuery: (previousResultData, fetchMoreResultData) {
          if (fetchMoreResultData == null || fetchMoreResultData['user']['boards']['nodes'].length == 0) {
            return previousResultData;
          }

          fetchMoreResultData['user']['boards']['nodes'] = [
            ...previousResultData?['user']['boards']['nodes'],
            ...fetchMoreResultData['user']['boards']['nodes']
                .where(
                  (node) =>
                      previousResultData?['user']['boards']['nodes'].map((node1) => node1['id']).contains(node['id']) !=
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
    return Query$User$Widget(
      options: Options$Query$User(variables: Variables$Query$User(username: widget.username)),
      builder: (result, {fetchMore, refetch}) {
        return QueryResultBuilder(
          result: result,
          buildIf: (parsedData) => parsedData?.user != null,
          noResultWidget: const NotFoundScreen(),
          builder: (parsedData) {
            final user = parsedData.user;

            return ScreenTitle(
              title: '@${user!.username}',
              child: Scaffold(
                appBar: AppBar(leading: BackButton(onPressed: () => context.goNamed(routeNameHome))),
                body: InfiniteScrollView(
                  hasMore: _hasNextPage,
                  onScrollAtBottom: _onScrollAtBottom,
                  child: Column(
                    spacing: 16,
                    children: [
                      Center(child: UserAvatarImage(user: user, size: 64)),
                      Text(
                        '@${user.username}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      Query$UserBoards$Widget(
                        options: Options$Query$UserBoards(
                          fetchPolicy: FetchPolicy.noCache,
                          variables: Variables$Query$UserBoards(username: widget.username, first: 12),
                        ),
                        builder: (result, {fetchMore, refetch}) {
                          _fetchMore ??= fetchMore;

                          return QueryResultBuilder(
                            result: result,
                            buildIf: (parsedData) => parsedData?.user?.boards.nodes.isNotEmpty == true,
                            refetch: refetch,
                            builder: (parsedData) {
                              final boards = parsedData.user!.boards;

                              _endCursor = boards.pageInfo.endCursor;
                              _hasNextPage = boards.pageInfo.hasNextPage;

                              return BoardsGridView(boards: boards.nodes);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
