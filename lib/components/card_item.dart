import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toolbox/components.dart';

import '../graphql/fragments/card_fragment.graphql.dart';
import '../graphql/mutations/update_card_list.graphql.dart';
import '../graphql/mutations/update_card_position.graphql.dart';
import '../graphql_client.dart';
import 'loading_dialog.dart';

class DraggableCardItem extends StatefulWidget {
  const DraggableCardItem({super.key, required this.card, required this.onDragOutside, required this.onDragEnded});

  final Fragment$CardFragment card;
  final Function() onDragOutside;
  final Function() onDragEnded;

  @override
  State<DraggableCardItem> createState() => _DraggableCardItemState();
}

class _DraggableCardItemState extends State<DraggableCardItem> {
  final GlobalKey _childKey = GlobalKey();
  Size? _childSize;
  Offset? _initialOffset;
  bool _isOutside = false;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: widget.card,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.75, child: CardItem(card: widget.card)),
      ),
      childWhenDragging: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: _isOutside ? 0 : _childSize?.height,
        decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(16)),
      ),
      onDragStarted: () {
        final renderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          setState(() {
            _childSize = renderBox.size;
          });
        }
      },
      onDragUpdate: (details) {
        final currentOffset = details.globalPosition;
        _initialOffset ??= currentOffset;

        if (!_isOutside &&
            (currentOffset.dx > _initialOffset!.dx + 80 ||
                currentOffset.dx < _initialOffset!.dx - 80 ||
                currentOffset.dy > _initialOffset!.dy + 30 ||
                currentOffset.dy < _initialOffset!.dy - 30)) {
          setState(() {
            _isOutside = true;
          });

          widget.onDragOutside();
        }
      },
      onDraggableCanceled: (velocity, offset) {
        setState(() {
          _initialOffset = null;
          _isOutside = false;
        });
        widget.onDragEnded();
      },
      onDragEnd: (details) {
        setState(() {
          _initialOffset = null;
          _isOutside = false;
        });
        widget.onDragEnded();
      },
      child: CardItem(key: _childKey, card: widget.card),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.card});

  final Fragment$CardFragment card;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 296,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(16)),
      child: Text(card.content),
    );
  }
}

class CardItemDragTarget extends StatelessWidget {
  const CardItemDragTarget({
    super.key,
    required this.listId,
    required this.position,
    required this.isVisible,
    required this.onAccept,
  });

  final String listId;
  final int position;
  final bool isVisible;
  final FutureOr<void> Function() onAccept;

  Future<void> _attemptToUpdateCardPosition(BuildContext context, Fragment$CardFragment card, int position) async {
    int newPosition = position;

    if (card.position < position) {
      newPosition = position - 1;
    }

    if (card.position == newPosition) {
      return;
    }

    final loadingDialog = showLoadingDialog(context);

    final graphqlClient = context.graphQLClient.value;
    final result = await graphqlClient.mutate$UpdateCardPosition(
      Options$Mutation$UpdateCardPosition(
        variables: Variables$Mutation$UpdateCardPosition(id: card.id, position: newPosition),
      ),
    );

    if (result.parsedData?.updateCardPosition == null && context.mounted) {
      showSnackBarAlert(context, 'Failed to update card position');
    }

    await onAccept();

    loadingDialog.close();
  }

  Future<void> _attemptToUpdateCardList(
    BuildContext context,
    Fragment$CardFragment card,
    String listId,
    int position,
  ) async {
    final loadingDialog = showLoadingDialog(context);

    final graphqlClient = context.graphQLClient.value;
    final result = await graphqlClient.mutate$UpdateCardList(
      Options$Mutation$UpdateCardList(
        variables: Variables$Mutation$UpdateCardList(id: card.id, listId: listId, position: position),
      ),
    );

    if (result.parsedData?.updateCardList == null && context.mounted) {
      showSnackBarAlert(context, 'Failed to update card list');
    }

    await onAccept();

    loadingDialog.close();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: DragTarget<Fragment$CardFragment>(
        builder: (context, accepted, rejected) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 6),
            height: accepted.isNotEmpty ? 48 : 12,
            decoration: BoxDecoration(
              color: accepted.isNotEmpty ? Colors.white30 : Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
        onAcceptWithDetails: (details) async {
          final card = details.data;

          if (listId == card.listId) {
            _attemptToUpdateCardPosition(context, card, position);
          } else {
            _attemptToUpdateCardList(context, card, listId, position);
          }
        },
      ),
    );
  }
}
