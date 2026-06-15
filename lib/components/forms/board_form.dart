import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../graphql/fragments/board_fragment.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql_client.dart';
import 'form_container.dart';
import 'text_input_field.dart';
import '../dropdown_field.dart';

class BoardForm<T> extends StatefulWidget {
  const BoardForm({super.key, required this.formKey, this.initialValues, required this.onSubmit});

  final GlobalKey<FormState> formKey;
  final Fragment$BoardFragment? initialValues;
  final Future<QueryResult<T>> Function(Input$BoardParams params) onSubmit;

  @override
  State<BoardForm> createState() => _BoardFormState();
}

class _BoardFormState<T> extends State<BoardForm<T>> {
  final _slugController = TextEditingController();

  String _name = '';
  String _description = '';
  Enum$BoardVisibility _visibility = Enum$BoardVisibility.PRIVATE;
  String? _errorName;
  String? _errorSlug;

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      _name = widget.initialValues!.name;
      _slugController.text = widget.initialValues!.slug;
      _description = widget.initialValues!.description;
      _visibility = widget.initialValues!.visibility;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: widget.formKey,
      onSubmit: () async {
        final result = await widget.onSubmit(
          Input$BoardParams(
            name: _name,
            slug: _slugController.text,
            description: _description,
            visibility: _visibility,
          ),
        );

        if (result.hasErrors) {
          setState(() {
            _errorName = result.getParamError('name');
            _errorSlug = result.getParamError('slug');
          });

          return result.errorMessage;
        }

        return null;
      },
      fields: [
        TextInputField(
          labelText: 'Name',
          errorText: _errorName,
          initialValue: _name,
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
        ),
        TextInputField(
          labelText: 'Description',
          initialValue: _description,
          keyboardType: TextInputType.multiline,
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
    );
  }
}
