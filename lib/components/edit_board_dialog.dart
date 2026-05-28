import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../constants.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import '../graphql/mutations/update_board.graphql.dart';
import 'board_form.dart';
import 'snackbar_alert.dart';

Future<dynamic> showEditBoardDialog(BuildContext context, {required Fragment$BoardFragment board}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Board'),
        content: _EditBoardForm(board: board),
      );
    },
  );
}

class _EditBoardForm extends StatelessWidget {
  _EditBoardForm({required this.board});

  final Fragment$BoardFragment board;

  final _formEditBoard = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToUpdateBoard(BuildContext context, Input$BoardParams params) async {
    final result = await context.graphQLClient.mutate$UpdateBoard(
      Options$Mutation$UpdateBoard(
        variables: Variables$Mutation$UpdateBoard(id: board.id, params: params),
      ),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final updatedBoard = result.parsedData?.updateBoard;

    if (updatedBoard != null) {
      showSnackBarAlert(context, 'Board updated successfully');

      if (board.slug == updatedBoard.slug) {
        context.pop();
      } else {
        context.pop();
        context.goNamed(routeNameBoard, pathParameters: {keySlug: updatedBoard.slug});
      }

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to update board');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BoardForm(
      formKey: _formEditBoard,
      initialValues: board,
      onSubmit: (params) => _attemptToUpdateBoard(context, params),
    );
  }
}
