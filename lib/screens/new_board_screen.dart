import 'package:boards/graphql/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/dropdown_field.dart';
import '../components/form_container.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../components/text_input_field.dart';
import '../constants.dart';
import '../graphql_client.dart';
import '../graphql/mutations/create_board.graphql.dart';

class NewBoardScreen extends StatefulWidget {
  const NewBoardScreen({super.key});

  @override
  State<NewBoardScreen> createState() => _NewBoardScreenState();
}

class _NewBoardScreenState extends State<NewBoardScreen> {
  final _formNewBoard = GlobalKey<FormState>();
  final _slugController = TextEditingController();

  String _name = '';
  String _slug = '';
  String _description = '';
  Enum$BoardVisibility _visibility = Enum$BoardVisibility.PRIVATE;
  String? _errorName;
  String? _errorSlug;

  void _attemptToCreateBoard() async {
    setState(() {
      _errorName = null;
      _errorSlug = null;
    });

    if (_formNewBoard.currentState?.validate() == true) {
      _formNewBoard.currentState?.save();
      final graphQLClient = context.graphQLClient.value;
      final result = await graphQLClient.mutate$CreateBoard(
        Options$Mutation$CreateBoard(
          variables: Variables$Mutation$CreateBoard(
            params: Input$BoardParams(name: _name, slug: _slug, description: _description, visibility: _visibility),
          ),
        ),
      );

      if (!mounted) {
        return;
      }

      final errors = result.exception?.graphqlErrors.first;

      if (result.parsedData?.createBoard != null) {
        showSnackBarAlert(context, 'Board created successfully');

        final board = result.parsedData!.createBoard;

        context.goNamed(routeNameShowBoard, pathParameters: {keySlug: board.slug});
      } else {
        showSnackBarAlert(context, errors?.message ?? 'Failed to create board');

        setState(() {
          _errorName = errors?.extensions?['params']['name']?['message'];
          _errorSlug = errors?.extensions?['params']['slug']?['message'];
        });
      }
    } else {
      showSnackBarAlert(context, 'Failed to create board');
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
            child: FormContainer(
              formKey: _formNewBoard,
              onSubmit: _attemptToCreateBoard,
              fields: [
                TextInputField(
                  labelText: 'Name',
                  errorText: _errorName,
                  required: true,
                  maxLines: 1,
                  onChanged: (value) {
                    _slugController.text =
                        value
                            ?.replaceFirst(RegExp(r'[^a-zA-Z0-9]+$'), '')
                            .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '-')
                            .toLowerCase() ??
                        '';
                  },
                  onSaved: (value) {
                    _name = value ?? '';
                  },
                ),
                TextInputField(
                  controller: _slugController,
                  labelText: 'Slug',
                  errorText: _errorSlug,
                  required: true,
                  maxLines: 1,
                  onSaved: (value) {
                    _slug = value ?? '';
                  },
                ),
                TextInputField(
                  labelText: 'Description',
                  maxLines: 4,
                  onSaved: (value) {
                    _description = value ?? '';
                  },
                ),
                DropdownField(
                  labelText: 'Visibility',
                  initialValue: _visibility,
                  items: [
                    DropdownMenuItem(value: Enum$BoardVisibility.PRIVATE, child: Text('Private')),
                    DropdownMenuItem(value: Enum$BoardVisibility.USERS, child: Text('Only users')),
                    DropdownMenuItem(value: Enum$BoardVisibility.PUBLIC, child: Text('Public')),
                  ],
                  onChanged: (value) {
                    _visibility = value!;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
