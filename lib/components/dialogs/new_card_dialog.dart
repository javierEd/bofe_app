import 'package:bofe/graphql/fragments/list_fragment.graphql.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../build_context.dart';
import '../forms/card_form.dart';
import '../scrollable_dialog.dart';
import '../snackbar_alert.dart';
import '../../graphql/fragments/board_fragment.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql/mutations/create_card.graphql.dart';

Future<dynamic> showNewCardDialog(
  BuildContext context, {
  required Fragment$BoardFragment board,
  required Fragment$ListFragment list,
}) {
  return showDialog(
    context: context,
    builder: (context) => _NewCardDialog(board: board, list: list),
  );
}

class _NewCardDialog extends StatelessWidget {
  _NewCardDialog({required this.board, required this.list});

  final Fragment$BoardFragment board;
  final Fragment$ListFragment list;
  final _formNewCard = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToCreateCard(BuildContext context, Input$CardParams params) async {
    final result = await context.graphQLClient.mutate$CreateCard(
      Options$Mutation$CreateCard(variables: Variables$Mutation$CreateCard(params: params)),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final createdCard = result.parsedData?.createCard;

    if (createdCard != null) {
      context.pop();

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to create card');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text('New Card'),
      child: CardForm(
        formKey: _formNewCard,
        boardId: board.id,
        initialList: list,
        onSubmit: (params) => _attemptToCreateCard(context, params),
      ),
    );
  }
}

class NewCardDialogExtra {
  NewCardDialogExtra({required this.list});

  final Fragment$ListFragment list;
}
