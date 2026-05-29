import 'package:flutter/material.dart';

import '../build_context.dart';
import '../graphql/fragments/list_fragment.graphql.dart';
import '../graphql/fragments/card_fragment.graphql.dart';
import '../graphql/queries/board_lists.graphql.dart';
import '../graphql/schema.graphql.dart';
import 'dropdown_search_field.dart';
import 'form_container.dart';
import 'text_input_field.dart';

class CardForm extends StatefulWidget {
  const CardForm({
    super.key,
    required this.formKey,
    required this.boardId,
    this.initialList,
    this.initialValues,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final String boardId;
  final Fragment$ListFragment? initialList;
  final Fragment$CardFragment? initialValues;
  final Future<Map<String, dynamic>?> Function(Input$CardParams params) onSubmit;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  String _content = '';
  Fragment$ListFragment? _list;
  String? _errorContent;
  String? _errorList;

  @override
  void initState() {
    super.initState();
    _content = widget.initialValues?.content ?? '';
    _list = widget.initialValues?.list ?? widget.initialList;
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: widget.formKey,
      onSubmit: () async {
        if (widget.formKey.currentState?.validate() == true) {
          widget.formKey.currentState?.save();
          final errors = await widget.onSubmit(Input$CardParams(listId: _list!.id, content: _content));

          if (errors != null) {
            setState(() {
              _errorContent = errors['listId']?['message'];
              _errorContent = errors['content']?['message'];
            });
          }
        }
      },
      fields: [
        DropdownSearchField<Fragment$ListFragment>(
          labelText: 'List',
          errorText: _errorList,
          initialValue: _list,
          required: true,
          compareFn: (item1, item2) => item1.id == item2.id,
          itemAsString: (item) => item.name,
          items: (filter, loadProps) async {
            final result = await context.graphQLClient.query$BoardLists(
              Options$Query$BoardLists(variables: Variables$Query$BoardLists(id: widget.boardId)),
            );

            return result.parsedData?.board?.allLists ?? [];
          },
          onSelected: (list) {
            setState(() {
              _list = list;
            });
          },
        ),
        TextInputField(
          labelText: 'Content',
          errorText: _errorContent,
          keyboardType: TextInputType.multiline,
          initialValue: _content,
          required: true,
          minLines: 4,
          maxLines: 100,
          onSaved: (value) {
            _content = value ?? '';
          },
        ),
      ],
    );
  }
}
