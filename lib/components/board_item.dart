import 'package:bofe/build_context.dart';
import 'package:flutter/material.dart';

import '../graphql/schema.graphql.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import 'user_item.dart';

class BoardItem extends StatelessWidget {
  const BoardItem({super.key, required this.board});

  final Fragment$BoardFragment board;

  Icon _getVisibilityIcon() {
    switch (board.visibility) {
      case Enum$BoardVisibility.PRIVATE:
        return Icon(Icons.lock_rounded);
      case Enum$BoardVisibility.USERS:
        return Icon(Icons.group_rounded);
      default:
        return Icon(Icons.public_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.router.pushToBoard(board),
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: colorScheme.onInverseSurface),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    board.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(board.description),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.onInverseSurface.withValues(alpha: 0),
                      colorScheme.onInverseSurface.withValues(alpha: 0.25),
                      colorScheme.onInverseSurface.withValues(alpha: 0.5),
                      colorScheme.onInverseSurface.withValues(alpha: 0.75),
                      colorScheme.onInverseSurface.withValues(alpha: 1),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserItem(user: board.user),
                    _getVisibilityIcon(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
