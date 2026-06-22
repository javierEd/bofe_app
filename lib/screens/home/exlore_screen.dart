import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../graphql/queries/boards.graphql.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Query$Boards$Widget(
      options: Options$Query$Boards(variables: Variables$Query$Boards(first: 12)),
      builder: (result, {fetchMore, refetch}) {
        final hasNextPage = result.parsedData?.boards.pageInfo.hasNextPage ?? false;
        final endCursor = result.parsedData?.boards.pageInfo.endCursor;

        return InfiniteScrollView(
          hasMore: hasNextPage,
          onScrollAtBottom: () async {
            await fetchMore?.call(
              FetchMoreOptions$Query$Boards(
                variables: Variables$Query$Boards(after: endCursor),
                updateQuery: (previousResultData, fetchMoreResultData) {
                  if (fetchMoreResultData == null || fetchMoreResultData['boards']['nodes'].length == 0) {
                    return previousResultData;
                  }

                  fetchMoreResultData['boards']['nodes'] = [
                    ...previousResultData?['boards']['nodes'],
                    ...fetchMoreResultData['boards']['nodes']
                        .where(
                          (node) =>
                              previousResultData?['boards']['nodes'].map((node1) => node1['id']).contains(node['id']) !=
                              true,
                        )
                        .toList(),
                  ];

                  return fetchMoreResultData;
                },
              ),
            );
          },
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.explore, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              QueryResultBuilder(
                result: result,
                buildIf: (data) => data?.boards.nodes.isNotEmpty == true,
                refetch: refetch,
                builder: (data) => BoardsGridView(boards: data.boards.nodes),
              ),
            ],
          ),
        );
      },
    );
  }
}
