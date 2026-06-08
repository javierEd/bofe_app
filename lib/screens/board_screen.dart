import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../components/board_context.dart';
import '../components/edit_board_dialog.dart';
import '../components/list_item.dart';
import '../components/loading_overlay.dart';
import '../components/new_list_dialog.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import '../graphql/mutations/delete_board.graphql.dart';
import '../graphql/subscriptions/board.graphql.dart';
import '../screens/not_found_screen.dart';
import '../value_keys.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key, required this.username, required this.slug});

  final String username;
  final String slug;

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  String? _draggingListId;
  bool _isDraggingCard = false;
  final _scrollController = ScrollController();
  bool _isAnimating = false;
  final _pixelsPerSecond = 250.0;
  final _edgeThreshold = 50;

  Future<void> _attemptToDeleteBoard(String id) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await context.graphQLClient.mutate$DeleteBoard(
      Options$Mutation$DeleteBoard(variables: Variables$Mutation$DeleteBoard(id: id)),
    );

    if (!mounted) {
      return;
    }

    if (result.parsedData?.deleteBoard == true) {
      context.pop();
    } else {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to delete board');
    }

    loadingOverlay.hide();
  }

  List<Widget> _getActions(Fragment$BoardFragment board) {
    return [
      IconButton(
        onPressed: () => context.router.goToMembers(board),
        tooltip: 'Members',
        icon: Icon(Icons.groups_3_rounded),
      ),

      if (board.isEditable)
        PopupMenuButton(
          icon: Icon(Icons.more_vert_rounded),
          tooltip: 'More',
          position: PopupMenuPosition.under,
          onSelected: (value) {
            switch (value) {
              case 1:
                showEditBoardDialog(context, board: board);
                break;
              case 2:
                context.router.goToLabels(board);
                break;
              case 3:
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm your action'),
                    content: const Text('Are you sure you want to delete this board?'),
                    actions: [
                      OutlinedButton(child: const Text('Cancel'), onPressed: () => context.pop()),
                      FilledButton(
                        child: const Text('Confirm'),
                        onPressed: () {
                          context.pop();
                          _attemptToDeleteBoard(board.id);
                        },
                      ),
                    ],
                  ),
                );
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: ListTile(leading: Icon(Icons.edit_rounded), title: Text('Edit')),
            ),
            PopupMenuItem(
              value: 2,
              child: ListTile(leading: Icon(Icons.label_rounded), title: Text('Labels')),
            ),
            PopupMenuItem(
              value: 3,
              child: ListTile(leading: Icon(Icons.delete_rounded), title: Text('Delete')),
            ),
          ],
        ),
    ];
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_isDraggingCard || _draggingListId != null) {
      final pointerPosition = event.localPosition;

      if (!_isAnimating) {
        if (pointerPosition.dx <= _edgeThreshold) {
          setState(() {
            _isAnimating = true;
          });
          final minExtent = _scrollController.position.minScrollExtent;
          final distanceToScroll = (_scrollController.offset - minExtent).abs();
          final durationMs = ((distanceToScroll / _pixelsPerSecond) * 1000).round();

          _scrollController.animateTo(
            minExtent,
            duration: Duration(milliseconds: durationMs),
            curve: Curves.easeInOut,
          );
        } else if (!_isAnimating &&
            pointerPosition.dx >= _scrollController.position.viewportDimension - _edgeThreshold) {
          setState(() {
            _isAnimating = true;
          });

          final maxExtent = _scrollController.position.maxScrollExtent;
          final distanceToScroll = (maxExtent - _scrollController.offset).abs();
          final durationMs = ((distanceToScroll / _pixelsPerSecond) * 1000).round();

          _scrollController.animateTo(
            maxExtent,
            duration: Duration(milliseconds: durationMs),
            curve: Curves.easeInOut,
          );
        }
      } else if (pointerPosition.dx > _edgeThreshold &&
          pointerPosition.dx < _scrollController.position.viewportDimension - _edgeThreshold) {
        setState(() {
          _isAnimating = false;
        });

        _scrollController.jumpTo(_scrollController.offset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BoardContext(
      key: ValueKeys.boardContext(widget.username, widget.slug),
      username: widget.username,
      slug: widget.slug,
      builder: (board) {
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
              actions: _getActions(board),
            ),
            body: Subscription$Board$Widget(
              options: Options$Subscription$Board(variables: Variables$Subscription$Board(id: board.id)),
              builder: (result) {
                final board = result.parsedData?.board;

                if (board == null) {
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const NotFoundScreen();
                  }
                }

                return Listener(
                  onPointerMove: _onPointerMove,
                  onPointerUp: (event) {
                    setState(() {
                      _isAnimating = false;
                    });
                  },
                  onPointerCancel: (event) {
                    setState(() {
                      _isAnimating = false;
                    });
                  },
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: _draggingListId == null ? 12 : 0,
                        children:
                            board.allLists
                                .map(
                                  (list) => board.canMoveList
                                      ? [
                                          ListItemDragTarget(
                                            position: list.position,
                                            isVisible: _draggingListId != null && _draggingListId != list.id,
                                          ),
                                          DraggableListItem(
                                            board: board,
                                            list: list,
                                            isDraggingCard: _isDraggingCard,
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
                                            onCardDragOutside: () {
                                              setState(() {
                                                _isDraggingCard = true;
                                              });
                                            },
                                            onCardDragEnded: () {
                                              setState(() {
                                                _isDraggingCard = false;
                                              });
                                            },
                                          ),
                                        ]
                                      : [
                                          ListItem(
                                            key: ValueKey(list.id),
                                            board: board,
                                            list: list,
                                            isDraggingCard: _isDraggingCard,
                                            onCardDragOutside: () {
                                              setState(() {
                                                _isDraggingCard = true;
                                              });
                                            },
                                            onCardDragEnded: () {
                                              setState(() {
                                                _isDraggingCard = false;
                                              });
                                            },
                                          ),
                                        ],
                                )
                                .expand((item) => item)
                                .toList() +
                            [
                              if (board.canMoveList)
                                ListItemDragTarget(
                                  position: board.allLists.lastOrNull?.position != null
                                      ? board.allLists.lastOrNull!.position + 1
                                      : 0,
                                  isVisible: _draggingListId != null,
                                ),
                              if (board.canCreateList)
                                SizedBox(
                                  width: 320,
                                  child: OutlinedButton(
                                    onPressed: () => showNewListDialog(context, boardId: board.id),
                                    child: Text('NEW LIST'),
                                  ),
                                ),
                            ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
