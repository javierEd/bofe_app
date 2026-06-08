import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/label_chip.dart';
import '../components/loading_overlay.dart';
import '../components/query_result_builder.dart';
import '../components/scrollable_dialog.dart';
import '../components/snackbar_alert.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import '../graphql/mutations/delete_label.graphql.dart';
import '../graphql/queries/board_labels.graphql.dart';

class LabelsDialogScreen extends StatefulWidget {
  const LabelsDialogScreen({super.key, required this.board});

  final Fragment$BoardFragment board;

  @override
  State<LabelsDialogScreen> createState() => _LabelsDialogScreenState();
}

class _LabelsDialogScreenState extends State<LabelsDialogScreen> {
  Future<void> _attemptToDeleteLabel(BuildContext context, {required String id, required Function() onSuccess}) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await context.graphQLClient.mutate$DeleteLabel(
      Options$Mutation$DeleteLabel(variables: Variables$Mutation$DeleteLabel(id: id)),
    );

    if (!context.mounted) {
      return;
    }

    if (result.parsedData?.deleteLabel == true) {
      onSuccess();
    } else {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to delete label');
    }

    loadingOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text('Labels'),
      actions: [
        if (widget.board.canCreateLabel)
          IconButton(
            onPressed: () {
              context.pop();
              showNewLabelDialog(context, board: widget.board);
            },
            tooltip: 'New Label',
            icon: const Icon(Icons.new_label_rounded),
          ),
      ],
      child: Query$BoardLabels$Widget(
        options: Options$Query$BoardLabels(variables: Variables$Query$BoardLabels(id: widget.board.id)),
        builder: (result, {fetchMore, refetch}) => QueryResultBuilder(
          result: result,
          buildIf: (parsedData) => parsedData?.board?.allLabels.isNotEmpty == true,
          refetch: refetch,
          builder: (parsedData) {
            final labels = parsedData.board?.allLabels ?? [];

            return Column(
              spacing: 3,
              children: labels
                  .map(
                    (label) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelChip(label: label),
                        if (label.isEditable)
                          Row(
                            spacing: 8,
                            children: [
                              PopupMenuButton(
                                icon: Icon(Icons.more_vert_rounded),
                                tooltip: 'More',
                                position: PopupMenuPosition.under,
                                onSelected: (value) {
                                  switch (value) {
                                    case 1:
                                      context.pop();
                                      showEditLabelDialog(context, board: widget.board, label: label);
                                      break;
                                    case 2:
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Confirm your action'),
                                          content: Text('Are you sure you want to delete this label?'),
                                          actions: [
                                            OutlinedButton(child: const Text('Cancel'), onPressed: () => context.pop()),
                                            FilledButton(
                                              child: const Text('Confirm'),
                                              onPressed: () {
                                                context.pop();
                                                _attemptToDeleteLabel(
                                                  context,
                                                  id: label.id,
                                                  onSuccess: () => refetch?.call(),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                      break;
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: ListTile(leading: Icon(Icons.edit_rounded), title: Text('Edit')),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: ListTile(leading: Icon(Icons.delete_rounded), title: Text('Delete')),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
