import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../build_context.dart';
import '../../graphql/fragments/board_fragment.graphql.dart';
import '../forms/label_form.dart';
import '../query_result_builder.dart';
import '../scrollable_dialog.dart';
import '../snackbar_alert.dart';
import '../../graphql/fragments/label_fragment.graphql.dart';
import '../../graphql/queries/label.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql/mutations/update_label.graphql.dart';

Future<dynamic> showEditLabelDialog(
  BuildContext context, {
  required Fragment$BoardFragment board,
  required Fragment$LabelFragment label,
}) {
  return showDialog(
    context: context,
    builder: (context) => _EditLabelDialog(board: board, label: label),
  );
}

class _EditLabelDialog extends StatelessWidget {
  _EditLabelDialog({required this.board, required this.label});

  final Fragment$BoardFragment board;
  final Fragment$LabelFragment label;

  final _formEditLabel = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToUpdateLabel(BuildContext context, String name, Color colorCode) async {
    final result = await context.graphQLClient.mutate$UpdateLabel(
      Options$Mutation$UpdateLabel(
        variables: Variables$Mutation$UpdateLabel(
          id: label.id,
          params: Input$UpdateLabelParams(name: name, colorCode: colorCode),
        ),
      ),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final updatedLabel = result.parsedData?.updateLabel;

    if (updatedLabel != null) {
      context.pop();
      context.router.goToLabels(board);

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to update label');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text('Edit Label'),
      child: Query$Label$Widget(
        options: Options$Query$Label(
          fetchPolicy: FetchPolicy.noCache,
          variables: Variables$Query$Label(id: label.id),
        ),
        builder: (result, {fetchMore, refetch}) {
          return QueryResultBuilder(
            result: result,
            refetch: refetch,
            buildIf: (parsedData) => parsedData?.label?.board.id == board.id && parsedData?.label?.isEditable == true,
            builder: (parsedData) {
              final label = parsedData.label!;

              return LabelForm(
                formKey: _formEditLabel,
                initialValues: label,
                onSubmit: (name, colorCode) => _attemptToUpdateLabel(context, name, colorCode),
              );
            },
          );
        },
      ),
    );
  }
}
