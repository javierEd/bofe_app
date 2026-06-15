import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../build_context.dart';
import '../forms/label_form.dart';
import '../scrollable_dialog.dart';
import '../../graphql/fragments/board_fragment.graphql.dart';
import '../../graphql/mutations/create_label.graphql.dart';
import '../../graphql/schema.graphql.dart';

Future<dynamic> showNewLabelDialog(BuildContext context, {required Fragment$BoardFragment board}) {
  return showDialog(
    context: context,
    builder: (context) => _NewLabelDialog(board: board),
  );
}

class _NewLabelDialog extends StatelessWidget {
  _NewLabelDialog({required this.board});

  final Fragment$BoardFragment board;
  final _formNewLabel = GlobalKey<FormState>();

  Future<QueryResult<Mutation$CreateLabel>> _attemptToCreateLabel(
    BuildContext context,
    String name,
    Color colorCode,
  ) async {
    final result = await context.graphQLClient.mutate$CreateLabel(
      Options$Mutation$CreateLabel(
        variables: Variables$Mutation$CreateLabel(
          params: Input$LabelParams(boardId: board.id, name: name, colorCode: colorCode),
        ),
      ),
    );

    if (!context.mounted) {
      return result;
    }

    final createdLabel = result.parsedData?.createLabel;

    if (createdLabel != null) {
      context.pop();
      context.router.goToLabels(board);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text('New Label'),
      child: LabelForm(
        formKey: _formNewLabel,
        onSubmit: (name, colorCode) => _attemptToCreateLabel(context, name, colorCode),
      ),
    );
  }
}
