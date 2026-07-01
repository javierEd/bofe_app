import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../build_context.dart';
import '../forms/card_form.dart';
import '../query_result_builder.dart';
import '../scrollable_dialog.dart';
import '../../graphql/fragments/card_fragment.graphql.dart';
import '../../graphql/queries/edit_card.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql/mutations/update_card.graphql.dart';

Future<dynamic> showEditCardDialog(BuildContext context, {required Fragment$CardFragment card}) {
  return showDialog(
    context: context,
    builder: (context) => _EditCardDialog(card: card),
  );
}

class _EditCardDialog extends StatelessWidget {
  _EditCardDialog({required this.card});

  final Fragment$CardFragment card;

  final _formEditCard = GlobalKey<FormState>();

  Future<QueryResult<Mutation$UpdateCard>> _attemptToUpdateCard(BuildContext context, Input$CardParams params) async {
    final result = await context.graphQLClient.mutate$UpdateCard(
      Options$Mutation$UpdateCard(
        variables: Variables$Mutation$UpdateCard(id: card.id, params: params),
      ),
    );

    if (!context.mounted) {
      return result;
    }

    final updatedCard = result.parsedData?.updateCard;

    if (updatedCard != null) {
      context.pop();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text('Edit Card'),
      child: Query$EditCard$Widget(
        options: Options$Query$EditCard(
          fetchPolicy: FetchPolicy.noCache,
          variables: Variables$Query$EditCard(id: card.id),
        ),
        builder: (result, {fetchMore, refetch}) {
          return QueryResultBuilder(
            result: result,
            refetch: refetch,
            buildIf: (parsedData) => parsedData?.card?.isEditable == true,
            builder: (parsedData) {
              final card = parsedData.card!;

              return CardForm(
                formKey: _formEditCard,
                boardId: card.board.id,
                initialValues: card,
                onSubmit: (params) => _attemptToUpdateCard(context, params),
              );
            },
          );
        },
      ),
    );
  }
}
