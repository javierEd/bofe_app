import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/list_item.dart';
import '../components/new_list_dialog.dart';
import '../components/screen_title.dart';
import '../constants.dart';
import '../graphql/queries/board.graphql.dart';
import '../graphql/queries/board_lists.graphql.dart';
import '../screens/not_found_screen.dart';

class ShowBoardScreen extends StatefulWidget {
  final String? username;

  final String slug;
  const ShowBoardScreen({super.key, this.username, required this.slug});

  @override
  State<ShowBoardScreen> createState() => _ShowBoardScreenState();
}

class _ShowBoardScreenState extends State<ShowBoardScreen> {
  String? _draggingListId;
  bool _draggingCard = false;
  int _refetchListsCount = 0;

  void _refetchLists() {
    setState(() {
      _refetchListsCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Query$Board$Widget(
      options: Options$Query$Board(variables: Variables$Query$Board(idOrSlug: widget.slug)),
      builder: (result, {fetchMore, refetch}) {
        final board = result.parsedData?.board;

        if (board == null || (widget.username != null && board.user.username != widget.username)) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NotFoundScreen();
          }
        }

        return ScreenTitle(
          title: '${board.name} by @${board.user.username}',
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(board.name),
                  Text('by @${board.user.username}', style: TextStyle(fontSize: 12)),
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
                      spacing: _draggingListId == null ? 12 : 0,
                      children:
                          lists
                              .map(
                                (list) => board.isEditable
                                    ? [
                                        ListItemDragTarget(
                                          position: list.position,
                                          isVisible: _draggingListId != null && _draggingListId != list.id,
                                          onAccept: () async {
                                            await refetch?.call();
                                          },
                                        ),
                                        DraggableListItem(
                                          list: list,
                                          showCardItemDragTargets: _draggingCard,
                                          refetchCount: _refetchListsCount,
                                          onDragOutside: () {
                                            setState(() {
                                              _draggingListId = list.id;
                                            });
                                          },
                                          onDragEnded: () {
                                            setState(() {
                                              _draggingListId = null;
                                            });
                                          },
                                          onCardAccept: () {
                                            refetch?.call();
                                            _refetchLists();
                                          },
                                          onCardDragOutside: () {
                                            setState(() {
                                              _draggingCard = true;
                                            });
                                          },
                                          onCardDragEnded: () {
                                            setState(() {
                                              _draggingCard = false;
                                            });
                                          },
                                        ),
                                      ]
                                    : [ListItem(list: list, isEditable: false, showCardItemDragTargets: false)],
                              )
                              .expand((item) => item)
                              .toList() +
                          (board.isEditable
                              ? [
                                  ListItemDragTarget(
                                    position: lists.lastOrNull?.position != null ? lists.lastOrNull!.position + 1 : 0,
                                    isVisible: _draggingListId != null,
                                    onAccept: () async {
                                      await refetch?.call();
                                    },
                                  ),
                                  SizedBox(
                                    width: 320,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        showNewListDialog(context, boardId: board.id).then((_) => refetch?.call());
                                      },
                                      child: Text('NEW LIST'),
                                    ),
                                  ),
                                ]
                              : []),
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
