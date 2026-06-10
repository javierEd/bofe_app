import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../build_context.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql/fragments/list_fragment.graphql.dart';
import '../../graphql/mutations/update_list.graphql.dart';
import '../forms/list_form.dart';
import '../snackbar_alert.dart';

Future<dynamic> showEditListDialog(BuildContext context, {required Fragment$ListFragment list}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit List'),
        content: _EditListForm(list: list),
      );
    },
  );
}

class _EditListForm extends StatelessWidget {
  _EditListForm({required this.list});

  final Fragment$ListFragment list;

  final _formEditList = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToUpdateList(BuildContext context, String name) async {
    final result = await context.graphQLClient.mutate$UpdateList(
      Options$Mutation$UpdateList(
        variables: Variables$Mutation$UpdateList(
          id: list.id,
          params: Input$UpdateListParams(name: name),
        ),
      ),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final updatedList = result.parsedData?.updateList;

    if (updatedList != null) {
      context.pop();

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to update list');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListForm(
      formKey: _formEditList,
      initialValues: list,
      onSubmit: (name) => _attemptToUpdateList(context, name),
    );
  }
}
