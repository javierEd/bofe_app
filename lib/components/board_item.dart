import 'package:flutter/material.dart';

import '../graphql/fragments/board_fragment.graphql.dart';

class BoardItem extends StatelessWidget {
  const BoardItem({super.key, required this.board, this.onTap});

  final Fragment$BoardFragment board;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          Container(width: double.infinity, height: double.infinity, color: const Color.fromRGBO(72, 64, 65, 0.40)),
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

          InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap),
        ],
      ),
    );
  }
}
