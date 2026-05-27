import 'package:flutter/material.dart';

import '../constants.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import 'user_item.dart';

class BoardItem extends StatelessWidget {
  const BoardItem({super.key, required this.board, this.onTap});

  final Fragment$BoardFragment board;
  final Function()? onTap;

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          Container(width: double.infinity, height: double.infinity, color: colorBoardItemBackground),
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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorBoardItemBackground.withValues(alpha: 0),
                    colorBoardItemBackground.withValues(alpha: 0.25),
                    colorBoardItemBackground.withValues(alpha: 0.5),
                    colorBoardItemBackground.withValues(alpha: 0.75),
                    colorBoardItemBackground.withValues(alpha: 1),
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
          InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap),
        ],
      ),
    );
  }
}
