import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/edit_board_dialog.dart';
import '../components/list_item.dart';
import '../components/loading_dialog.dart';
import '../components/new_list_dialog.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../constants.dart';
import '../graphql/mutations/delete_board.graphql.dart';
import '../graphql_client.dart';
import '../graphql/queries/board.graphql.dart';
import '../graphql/queries/board_lists.graphql.dart';
import '../router.dart';
import '../screens/not_found_screen.dart';

class ShowBoardScreen extends StatefulWidget {
  const ShowBoardScreen({super.key, this.username, required this.slug});

  final String? username;
  final String slug;

  @override
  State<ShowBoardScreen> createState() => _ShowBoardScreenState();
}

class _ShowBoardScreenState extends State<ShowBoardScreen> with RouteAware {
  String? _draggingListId;
  bool _draggingCard = false;
  int _refetchListsCount = -9007199254740991;
  Future<QueryResult<Query$Board>?> Function()? _refetch;

  Future<void> _attemptToDeleteBoard(String id) async {
    final loadingDialog = showLoadingDialog(context);
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

    loadingDialog.close();
  }

  void _refetchLists() {
    setState(() {
      _refetchListsCount++;
    });
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
    _refetchLists();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Query$Board$Widget(
      options: Options$Query$Board(variables: Variables$Query$Board(idOrSlug: widget.slug)),
      builder: (result, {fetchMore, refetch}) {
        _refetch ??= refetch;

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
              actions: (board.isEditable
                  ? [
                      IconButton(
                        onPressed: () => showEditBoardDialog(context, board: board),
                        tooltip: 'Edit',
                        icon: Icon(Icons.edit_rounded),
                      ),
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
                    ]
                  : null),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
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
                                            onChanged: () {
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
                                        onPressed: () =>
                                            showNewListDialog(context, boardId: board.id).then((_) => refetch?.call()),
                                        child: Text('NEW LIST'),
                                      ),
                                    ),
                                  ]
                                : []),
                      ),
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
