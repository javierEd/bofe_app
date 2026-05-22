import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../graphql/schema.graphql.dart';
import '../graphql/mutations/create_card.graphql.dart';
import '../graphql_client.dart';
import 'card_form.dart';
import 'snackbar_alert.dart';

Future<dynamic> showNewCardDialog(BuildContext context, {required listId}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('New Card'),
        content: _NewCardForm(listId: listId),
      );
    },
  );
}

class _NewCardForm extends StatelessWidget {
  _NewCardForm({required this.listId});

  final String listId;

  final _formNewCard = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToCreateCard(BuildContext context, String content) async {
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$CreateCard(
      Options$Mutation$CreateCard(
        variables: Variables$Mutation$CreateCard(
          params: Input$CardParams(listId: listId, content: content),
        ),
      ),
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
    return CardForm(formKey: _formNewCard, onSubmit: (content) => _attemptToCreateCard(context, content));
  }
}
