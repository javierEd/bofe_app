import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../graphql/schema.graphql.dart';
import '../graphql/mutations/create_list.graphql.dart';
import '../graphql_client.dart';
import 'list_form.dart';
import 'snackbar_alert.dart';

Future<dynamic> showNewListDialog(BuildContext context, {required boardId}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('New List'),
        content: _NewListForm(boardId: boardId),
      );
    },
  );
}

class _NewListForm extends StatefulWidget {
  const _NewListForm({required this.boardId});

  final String boardId;

  @override
  _NewListFormState createState() => _NewListFormState();
}

class _NewListFormState extends State<_NewListForm> {
  final _formNewList = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToCreateList(BuildContext context, String name) async {
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$CreateList(
      Options$Mutation$CreateList(
        variables: Variables$Mutation$CreateList(
          params: Input$ListParams(boardId: widget.boardId, name: name),
        ),
      ),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;

    if (result.parsedData?.createList != null) {
      showSnackBarAlert(context, 'List created successfully');

      context.pop();

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to create list');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListForm(formKey: _formNewList, onSubmit: (name) => _attemptToCreateList(context, name));
  }
}
