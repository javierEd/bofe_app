import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/loading_dialog.dart';
import '../graphql/fragments/list_fragment.graphql.dart';
import '../graphql/mutations/delete_list.graphql.dart';
import '../graphql/mutations/update_list_position.graphql.dart';
import '../graphql/queries/list_cards.graphql.dart';
import '../graphql_client.dart';
import 'card_item.dart';
import 'edit_list_dialog.dart';
import 'new_card_dialog.dart';
import 'snackbar_alert.dart';

class DraggableListItem extends StatefulWidget {
  const DraggableListItem({
    super.key,
    required this.list,
    required this.showCardItemDragTargets,
    required this.refetchCount,
    required this.onDragOutside,
    required this.onDragEnded,
    required this.onChanged,
    required this.onCardDragOutside,
    required this.onCardDragEnded,
  });

  final Fragment$ListFragment list;
  final bool showCardItemDragTargets;
  final int refetchCount;
  final Function() onDragOutside;
  final Function() onDragEnded;
  final Function() onChanged;
  final Function() onCardDragOutside;
  final Function() onCardDragEnded;

  @override
  State<DraggableListItem> createState() => _DraggableListItemState();
}

class _DraggableListItemState extends State<DraggableListItem> {
  double? _initialX;
  bool _isOutside = false;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: widget.list,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.75,
          child: ListItem(list: widget.list, isEditable: true, showCardItemDragTargets: false),
        ),
      ),
      childWhenDragging: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: _isOutside ? 0 : 320,
        decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(16)),
      ),
      onDragUpdate: (details) {
        final currentX = details.globalPosition.dx;
        _initialX ??= currentX;

        if (!_isOutside && (currentX > _initialX! + 100 || currentX < _initialX! - 100)) {
          setState(() {
            _isOutside = true;
          });

          widget.onDragOutside();
        }
      },
      onDraggableCanceled: (velocity, offset) {
        setState(() {
          _initialX = null;
          _isOutside = false;
        });
        widget.onDragEnded();
      },
      onDragEnd: (details) {
        setState(() {
          _initialX = null;
          _isOutside = false;
        });
        widget.onDragEnded();
      },
      child: ListItem(
        list: widget.list,
        isEditable: true,
        showCardItemDragTargets: widget.showCardItemDragTargets,
        refetchCount: widget.refetchCount,
        onChanged: widget.onChanged,
        onCardDragOutside: widget.onCardDragOutside,
        onCardDragEnded: widget.onCardDragEnded,
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    required this.list,
    required this.isEditable,
    required this.showCardItemDragTargets,
    this.refetchCount,
    this.onChanged,
    this.onCardDragOutside,
    this.onCardDragEnded,
  });

  final Fragment$ListFragment list;
  final bool isEditable;
  final bool showCardItemDragTargets;
  final int? refetchCount;
  final Function()? onChanged;
  final Function()? onCardDragOutside;
  final Function()? onCardDragEnded;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  String? _draggingCardId;
  Future<QueryResult<Query$ListCards>?> Function()? _refetch;

  Future<void> _attemptToDeleteList() async {
    final loadingDialog = showLoadingDialog(context);
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$DeleteList(
      Options$Mutation$DeleteList(variables: Variables$Mutation$DeleteList(id: widget.list.id)),
    );

    if (!mounted) {
      return;
    }

    if (result.parsedData?.deleteList != true) {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to delete list');
    }

    widget.onChanged?.call();

    loadingDialog.close();
  }

  @override
  void didUpdateWidget(covariant ListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refetchCount != oldWidget.refetchCount) {
      _refetch?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Query$ListCards$Widget(
        options: Options$Query$ListCards(variables: Variables$Query$ListCards(id: widget.list.id)),
        builder: (result, {fetchMore, refetch}) {
          _refetch ??= refetch;

          final cards = result.parsedData?.list?.cards.nodes;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children:
                <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.list.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      widget.list.isEditable
                          ? PopupMenuButton(
                              icon: Icon(Icons.more_vert_rounded),
                              tooltip: 'More',
                              position: PopupMenuPosition.under,
                              onSelected: (value) {
                                switch (value) {
                                  case 1:
                                    showEditListDialog(context, list: widget.list);
                                    break;
                                  case 2:
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirm your action'),
                                        content: const Text('Are you sure you want to delete this list?'),
                                        actions: [
                                          OutlinedButton(child: const Text('Cancel'), onPressed: () => context.pop()),
                                          FilledButton(
                                            child: const Text('Confirm'),
                                            onPressed: () {
                                              context.pop();
                                              _attemptToDeleteList();
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
                                  child: ListTile(leading: Icon(Icons.delete_rounded), title: Text('Delete')),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ] +
                (cards
                        ?.map(
                          (card) => widget.isEditable
                              ? [
                                  CardItemDragTarget(
                                    listId: widget.list.id,
                                    position: card.position,
                                    isVisible: widget.showCardItemDragTargets && _draggingCardId != card.id,
                                    onAccept: () {
                                      widget.onChanged?.call();
                                    },
                                  ),
                                  DraggableCardItem(
                                    card: card,
                                    onChanged: () {
                                      widget.onChanged?.call();
                                    },
                                    onDragOutside: () {
                                      setState(() {
                                        _draggingCardId = card.id;
                                      });
                                      widget.onCardDragOutside?.call();
                                    },
                                    onDragEnded: () {
                                      setState(() {
                                        _draggingCardId = null;
                                      });
                                      widget.onCardDragEnded?.call();
                                    },
                                  ),
                                ]
                              : [CardItem(card: card)],
                        )
                        .expand((item) => item)
                        .toList() ??
                    []) +
                (widget.isEditable
                    ? [
                        CardItemDragTarget(
                          listId: widget.list.id,
                          position: cards?.lastOrNull?.position != null ? cards!.lastOrNull!.position + 1 : 0,
                          isVisible: widget.showCardItemDragTargets,
                          onAccept: () {
                            widget.onChanged?.call();
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              showNewCardDialog(context, listId: widget.list.id).then((_) => refetch?.call());
                            },
                            child: Text('NEW CARD'),
                          ),
                        ),
                      ]
                    : []),
          );
        },
      ),
    );
  }
}

class ListItemDragTarget extends StatelessWidget {
  const ListItemDragTarget({super.key, required this.position, required this.isVisible, required this.onAccept});

  final int position;
  final bool isVisible;
  final FutureOr<void> Function() onAccept;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: DragTarget<Fragment$ListFragment>(
        builder: (context, accepted, rejected) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: accepted.isNotEmpty ? 320 : 16,
            decoration: BoxDecoration(
              color: accepted.isNotEmpty ? Colors.white30 : Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
        onAcceptWithDetails: (details) async {
          final list = details.data;
          int newPosition = position;

          if (list.position < position) {
            newPosition = position - 1;
          }

          if (list.position == newPosition) {
            return;
          }

          final loadingDialog = showLoadingDialog(context);

          final graphqlClient = context.graphQLClient.value;
          final result = await graphqlClient.mutate$UpdateListPosition(
            Options$Mutation$UpdateListPosition(
              variables: Variables$Mutation$UpdateListPosition(id: list.id, position: newPosition),
            ),
          );

          if (result.parsedData?.updateListPosition == null && context.mounted) {
            showSnackBarAlert(context, 'Failed to update list position');
          }

          await onAccept();

          loadingDialog.close();
        },
      ),
    );
  }
}
