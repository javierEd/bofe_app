import 'package:bofe/graphql/fragments/board_fragment.graphql.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import 'board_item.dart';

class BoardsGridView extends StatelessWidget {
  const BoardsGridView({super.key, required this.boards});

  final List<Fragment$BoardFragment> boards;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: boards.length,
      itemBuilder: (context, index) {
        final board = boards[index];

        return BoardItem(
          board: board,
          onTap: () => context.goNamed(routeNameShowBoard, pathParameters: {keySlug: board.slug}),
        );
      },
    );
  }
}
