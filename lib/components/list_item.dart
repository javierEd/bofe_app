import 'dart:async';

import 'package:flutter/material.dart';

import 'package:toolbox/components.dart';

import '../components/loading_dialog.dart';
import '../graphql/fragments/list_fragment.graphql.dart';
import '../graphql/mutations/update_list_position.graphql.dart';
import '../graphql_client.dart';

class DraggableListItem extends StatefulWidget {
  const DraggableListItem({super.key, required this.list, required this.onDragOutside, required this.onDragEnded});

  final Fragment$ListFragment list;
  final Function() onDragOutside;
  final Function() onDragEnded;

  @override
  State<DraggableListItem> createState() => _DraggableListItemState();
}

class _DraggableListItemState extends State<DraggableListItem> {
  double? _initialX;
  bool _isOutside = false;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.list,
      feedback: Opacity(opacity: 0.75, child: ListItem(list: widget.list)),
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
      child: ListItem(list: widget.list),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.list});

  final Fragment$ListFragment list;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(list.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            margin: const EdgeInsets.symmetric(horizontal: 24),
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
