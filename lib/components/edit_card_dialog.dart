import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../graphql/fragments/card_fragment.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/mutations/update_card.graphql.dart';
import '../graphql_client.dart';
import 'card_form.dart';
import 'snackbar_alert.dart';

Future<dynamic> showEditCardDialog(BuildContext context, {required Fragment$CardFragment card}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit card'),
        content: _EditCardForm(card: card),
      );
    },
  );
}

class _EditCardForm extends StatelessWidget {
  _EditCardForm({required this.card});

  final Fragment$CardFragment card;

  final _formEditList = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToUpdateCard(BuildContext context, String content) async {
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$UpdateCard(
      Options$Mutation$UpdateCard(
        variables: Variables$Mutation$UpdateCard(
          id: card.id,
          params: Input$UpdateCardParams(content: content),
        ),
      ),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final updatedCard = result.parsedData?.updateCard;

    if (updatedCard != null) {
      context.pop();

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to update card');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardForm(
      formKey: _formEditList,
      initialValues: card,
      onSubmit: (name) => _attemptToUpdateCard(context, name),
    );
  }
}
