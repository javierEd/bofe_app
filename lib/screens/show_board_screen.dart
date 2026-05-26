import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:single_child_two_dimensional_scroll_view/single_child_two_dimensional_scroll_view.dart';

import '../components/edit_board_dialog.dart';
import '../components/list_item.dart';
import '../components/loading_overlay.dart';
import '../components/new_list_dialog.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../constants.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import '../graphql/mutations/delete_board.graphql.dart';
import '../graphql/subscriptions/board.graphql.dart';
import '../graphql_client.dart';
import '../graphql/queries/board_by_slug.graphql.dart';
import '../router.dart';
import '../screens/not_found_screen.dart';

class ShowBoardScreen extends StatefulWidget {
  const ShowBoardScreen({super.key, required this.slug});

  final String slug;

  @override
  State<ShowBoardScreen> createState() => _ShowBoardScreenState();
}

class _ShowBoardScreenState extends State<ShowBoardScreen> with RouteAware {
  String? _draggingListId;
  bool _draggingCard = false;
  Refetch<Query$BoardBySlug>? _refetch;
  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

  double get _boardHeight => _verticalScrollController.hasClients
      ? _verticalScrollController.position.viewportDimension + _verticalScrollController.position.maxScrollExtent
      : 0;

  Future<void> _attemptToDeleteBoard(String id) async {
    final loadingOverlay = showLoadingOverlay(context);
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$DeleteBoard(
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
    List<Widget> actions = [];

    if (board.isEditable) {
      actions.add(
        IconButton(
          onPressed: () => showEditBoardDialog(context, board: board),
          tooltip: 'Edit',
          icon: Icon(Icons.edit_rounded),
        ),
      );
    }

    actions.add(
      IconButton(
        onPressed: () => context.goNamed(routeNameBoardMembers, pathParameters: {keySlug: board.slug}),
        tooltip: 'Members',
        icon: Icon(Icons.groups_3_rounded),
      ),
    );

    if (board.isEditable) {
      actions.add(
        PopupMenuButton(
          icon: Icon(Icons.more_vert_rounded),
          tooltip: 'More',
          position: PopupMenuPosition.under,
          onSelected: (value) {
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
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: ListTile(leading: Icon(Icons.delete_rounded), title: Text('Delete')),
            ),
          ],
        ),
      );
    }

    return actions;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentRoute = ModalRoute.of(context);

    if (currentRoute != null) {
      routeObserver.subscribe(this, currentRoute);
    }
  }

  @override
  void didPopNext() {
    _refetch?.call();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Query$BoardBySlug$Widget(
      options: Options$Query$BoardBySlug(variables: Variables$Query$BoardBySlug(slug: widget.slug)),
      builder: (result, {fetchMore, refetch}) {
        _refetch ??= refetch;

        final boardBySlug = result.parsedData?.boardBySlug;

        if (boardBySlug == null) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NotFoundScreen();
          }
        }

        return Subscription$Board$Widget(
          options: Options$Subscription$Board(variables: Variables$Subscription$Board(id: boardBySlug.id)),
          builder: (result) {
            final board = result.parsedData?.board;

            if (board == null) {
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
                  actions: _getActions(board),
                  leading: BackButton(onPressed: () => context.goNamed(routeNameHome)),
                ),
                body: Listener(
                  onPointerMove: (event) {
                    if (_draggingCard || _draggingListId != null) {
                      if (event.position.dx < 42) {
                        _horizontalScrollController.animateTo(
                          _horizontalScrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: _horizontalScrollController.offset.toInt() * 2),
                          curve: Curves.easeInOut,
                        );
                      } else if (event.position.dx > screenSize.width - 42) {
                        _horizontalScrollController.animateTo(
                          _horizontalScrollController.position.maxScrollExtent,
                          duration: Duration(
                            milliseconds:
                                (_horizontalScrollController.position.maxScrollExtent -
                                        _horizontalScrollController.offset)
                                    .toInt() *
                                2,
                          ),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _horizontalScrollController.jumpTo(_horizontalScrollController.offset);
                      }

                      if (event.position.dy < 100) {
                        _verticalScrollController.animateTo(
                          _verticalScrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: _verticalScrollController.offset.toInt() * 2),
                          curve: Curves.easeInOut,
                        );
                      } else if (event.position.dy > screenSize.height - 42) {
                        _verticalScrollController.animateTo(
                          _verticalScrollController.position.maxScrollExtent,
                          duration: Duration(
                            milliseconds:
                                (_verticalScrollController.position.maxScrollExtent - _verticalScrollController.offset)
                                    .toInt() *
                                2,
                          ),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _verticalScrollController.jumpTo(_verticalScrollController.offset);
                      }
                    }
                  },
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildTwoDimensionalScrollView(
                      padding: EdgeInsets.all(16),
                      horizontalController: _horizontalScrollController,
                      verticalController: _verticalScrollController,
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
                                            height: _boardHeight,
                                            onAccept: () async {
                                              await refetch?.call();
                                            },
                                          ),
                                          DraggableListItem(
                                            list: list,
                                            showCardItemDragTargets: _draggingCard,
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
                                      : [
                                          ListItem(
                                            list: list,
                                            showCardItemDragTargets: _draggingCard,
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
                                  height: _boardHeight,
                                  onAccept: () async {
                                    await refetch?.call();
                                  },
                                ),
                              if (board.canCreateList)
                                SizedBox(
                                  width: 320,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        showNewListDialog(context, boardId: board.id).then((_) => refetch?.call()),
                                    child: Text('NEW LIST'),
                                  ),
                                ),
                            ],
                      ),
                    ),
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
