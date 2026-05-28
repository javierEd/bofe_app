import 'package:bofe/build_context.dart';
import 'package:bofe/components/card_form.dart';
import 'package:flutter/material.dart';

import '../components/query_result_builder.dart';
import '../components/scrollable_dialog.dart';
import '../components/snackbar_alert.dart';
import '../graphql/queries/card.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/mutations/update_card.graphql.dart';

class EditCardDialogScreen extends StatelessWidget {
  EditCardDialogScreen({super.key, required this.boardSlug, required this.id});

  final String boardSlug;
  final String id;

  final _formEditList = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToUpdateCard(BuildContext context, String content) async {
    final result = await context.graphQLClient.mutate$UpdateCard(
      Options$Mutation$UpdateCard(
        variables: Variables$Mutation$UpdateCard(
          id: id,
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
      context.router.goToCard(updatedCard);

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to update card');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text('Edit Card'),
      child: Query$Card$Widget(
        options: Options$Query$Card(variables: Variables$Query$Card(id: id)),
        builder: (result, {fetchMore, refetch}) {
          return QueryResultBuilder(
            result: result,
            refetch: refetch,
            buildIf: (parsedData) => parsedData?.card?.board.slug == boardSlug && parsedData?.card?.isEditable == true,
            builder: (parsedData) {
              final card = parsedData.card!;

              return CardForm(
                formKey: _formEditList,
                initialValues: card,
                onSubmit: (content) => _attemptToUpdateCard(context, content),
              );
            },
          );
        },
      ),
    );
  }
}
