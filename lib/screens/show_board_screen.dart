import 'package:boards/graphql/queries/board_lists.graphql.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/new_list_dialog.dart';
import '../components/screen_title.dart';
import '../constants.dart';
import '../graphql/queries/board.graphql.dart';
import '../screens/not_found_screen.dart';

class ShowBoardScreen extends StatefulWidget {
  const ShowBoardScreen({super.key, this.username, required this.slug});

  final String? username;
  final String slug;

  @override
  State<ShowBoardScreen> createState() => _ShowBoardScreenState();
}

class _ShowBoardScreenState extends State<ShowBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Query$Board$Widget(
      options: Options$Query$Board(variables: Variables$Query$Board(idOrSlug: widget.slug)),
      builder: (result, {fetchMore, refetch}) {
        final board = result.parsedData?.board;

        if (board == null || (widget.username != null && board.user.identityUser.username != widget.username)) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NotFoundScreen();
          }
        }

        return ScreenTitle(
          title: '${board.name} by @${board.user.identityUser.username}',
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(board.name),
                  Text('by @${board.user.identityUser.username}', style: TextStyle(fontSize: 12)),
                ],
              ),
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              leading: BackButton(onPressed: () => context.goNamed(routeNameHome)),
            ),
            body: SizedBox(
              height: double.infinity,
              child: Query$BoardLists$Widget(
                options: Options$Query$BoardLists(variables: Variables$Query$BoardLists(idOrSlug: widget.slug)),
                builder: (result, {fetchMore, refetch}) {
                  final lists = result.parsedData?.board?.lists.nodes;

                  if (lists == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children:
                          lists
                              .map<Widget>(
                                (list) => Container(
                                  width: 320,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(list.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                              )
                              .toList() +
                          [
                            SizedBox(
                              width: 320,
                              child: OutlinedButton(
                                onPressed: () {
                                  showNewListDialog(context, boardId: board.id).then((_) => refetch?.call());
                                },
                                child: Text('NEW LIST'),
                              ),
                            ),
                          ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
