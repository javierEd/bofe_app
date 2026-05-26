import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'boards_grid_view.dart';
import 'infinite_scroll_view.dart';
import 'query_result_builder.dart';
import '../graphql/queries/boards.graphql.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _isLoadingNext = false;
  String? _endCursor;
  bool _hasNextPage = false;
  FetchMore<Query$Boards>? _fetchMore;

  void _onScrollAtBottom() {
    _fetchMore?.call(
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
      isLoading: _isLoadingNext,
      onScrollAtBottom: _onScrollAtBottom,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Explore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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

                  _isLoadingNext = result.isLoading && _hasNextPage;
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
