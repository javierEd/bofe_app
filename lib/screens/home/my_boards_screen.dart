import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../graphql/queries/current_user_boards.graphql.dart';
import '../../sessions_manager.dart';

class MyBoardsScreen extends StatefulWidget {
  const MyBoardsScreen({super.key});

  @override
  State<MyBoardsScreen> createState() => _MyBoardsScreenState();
}

class _MyBoardsScreenState extends State<MyBoardsScreen> {
  @override
  Widget build(BuildContext context) {
    if (SessionsManager.hasToken) {
      return Query$CurrentUserBoards$Widget(
        options: Options$Query$CurrentUserBoards(variables: Variables$Query$CurrentUserBoards(first: 12)),
        builder: (result, {fetchMore, refetch}) {
          final hasNextPage = result.parsedData?.currentUser?.boards.pageInfo.hasNextPage ?? false;
          final endCursor = result.parsedData?.currentUser?.boards.pageInfo.endCursor;

          return InfiniteScrollView(
            hasMore: hasNextPage,
            onScrollAtBottom: () async {
              await fetchMore?.call(
                FetchMoreOptions$Query$CurrentUserBoards(
                  variables: Variables$Query$CurrentUserBoards(after: endCursor),
                  updateQuery: (previousResultData, fetchMoreResultData) {
                    if (fetchMoreResultData == null ||
                        fetchMoreResultData['currentUser']['boards']['nodes'].length == 0) {
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
            },
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.myBoards, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                QueryResultBuilder(
                  result: result,
                  buildIf: (data) => data?.currentUser?.boards.nodes.isNotEmpty == true,
                  refetch: refetch,
                  builder: (data) {
                    final boards = data.currentUser!.boards;

                    return BoardsGridView(boards: boards.nodes);
                  },
                ),
              ],
            ),
          );
        },
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
