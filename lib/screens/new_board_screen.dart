import 'package:flutter/material.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/mutations/create_board.graphql.dart';

class NewBoardScreen extends StatelessWidget {
  NewBoardScreen({super.key});

  final _formNewBoard = GlobalKey<FormState>();

  Future<Map<String, dynamic>?> _attemptToCreateBoard(BuildContext context, Input$BoardParams params) async {
    final result = await context.graphQLClient.mutate$CreateBoard(
      Options$Mutation$CreateBoard(variables: Variables$Mutation$CreateBoard(params: params)),
    );

    if (!context.mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final createdBoard = result.parsedData?.createBoard;

    if (createdBoard != null) {
      showSnackBarAlert(context, 'Board created successfully');

      context.router.goToBoard(createdBoard);

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to create board');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTitle(
      title: 'New board',
      child: Scaffold(
        appBar: AppBar(title: Text('New board')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: BoardForm(formKey: _formNewBoard, onSubmit: (params) => _attemptToCreateBoard(context, params)),
          ),
        ),
      ),
    );
  }
}
