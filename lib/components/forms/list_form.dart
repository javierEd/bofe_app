import 'package:flutter/material.dart';

import '../../graphql/fragments/list_fragment.graphql.dart';
import 'form_container.dart';
import 'text_input_field.dart';

class ListForm extends StatefulWidget {
  const ListForm({super.key, required this.formKey, this.initialValues, required this.onSubmit});

  final GlobalKey<FormState> formKey;
  final Fragment$ListFragment? initialValues;
  final Future<Map<String, dynamic>?> Function(String name) onSubmit;

  @override
  State<ListForm> createState() => _ListFormState();
}

class _ListFormState extends State<ListForm> {
  String _name = '';
  String? _errorName;

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      _name = widget.initialValues!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: widget.formKey,
      onSubmit: () async {
        if (widget.formKey.currentState?.validate() == true) {
          widget.formKey.currentState?.save();
          final errors = await widget.onSubmit(_name);

          if (errors != null) {
            setState(() {
              _errorName = errors['name']?['message'];
            });
          }
        }
      },
      fields: [
        TextInputField(
          labelText: 'Name',
          errorText: _errorName,
          initialValue: _name,
          required: true,
          maxLines: 1,
          onSaved: (value) {
            _name = value ?? '';
          },
        ),
      ],
    );
  }
}
