import 'package:bofe/graphql/fragments/list_fragment.graphql.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../components/card_form.dart';
import '../components/query_result_builder.dart';
import '../components/scrollable_dialog.dart';
import '../components/snackbar_alert.dart';
import '../graphql/queries/board_by_slug.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/mutations/create_card.graphql.dart';

class NewCardDialogScreen extends StatelessWidget {
  NewCardDialogScreen({super.key, required this.boardSlug, required this.extra});

  final String boardSlug;
  final NewCardDialogExtra? extra;
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
      child: Query$BoardBySlug$Widget(
        options: Options$Query$BoardBySlug(variables: Variables$Query$BoardBySlug(slug: boardSlug)),
        builder: (result, {fetchMore, refetch}) {
          return QueryResultBuilder(
            result: result,
            refetch: refetch,
            buildIf: (parsedData) => parsedData?.boardBySlug?.slug == boardSlug,
            builder: (parsedData) {
              final board = parsedData.boardBySlug!;

              return CardForm(
                formKey: _formNewCard,
                boardId: board.id,
                initialList: extra?.list,
                onSubmit: (params) => _attemptToCreateCard(context, params),
              );
            },
          );
        },
      ),
    );
  }
}

class NewCardDialogExtra {
  NewCardDialogExtra({required this.list});

  final Fragment$ListFragment list;
}
