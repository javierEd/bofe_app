import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'boards_grid_view.dart';
import 'infinite_scroll_view.dart';
import 'login_buttons.dart';
import 'query_result_builder.dart';
import '../session_manager.dart';
import '../graphql/queries/current_user_boards.graphql.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingNext = false;
  String? _endCursor;
  bool _hasNextPage = false;
  FetchMore<Query$CurrentUserBoards>? _fetchMore;

  void _onScrollAtBottom() {
    _fetchMore?.call(
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
        isLoading: _isLoadingNext,
        onScrollAtBottom: _onScrollAtBottom,
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Boards', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Query$CurrentUserBoards$Widget(
              options: Options$Query$CurrentUserBoards(variables: Variables$Query$CurrentUserBoards(first: 12)),
              builder: (result, {fetchMore, refetch}) {
                _isLoadingNext = result.isLoading && _hasNextPage;
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
            children: [Text('You must be logged in to view your boards 😏'), LoginButtons()],
          ),
        ),
      );
    }
  }
}
