import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../graphql/fragments/label_fragment.graphql.dart';
import '../form_container.dart';
import '../text_input_field.dart';

class LabelForm extends StatefulWidget {
  const LabelForm({super.key, required this.formKey, this.initialValues, required this.onSubmit});

  final GlobalKey<FormState> formKey;
  final Fragment$LabelFragment? initialValues;
  final Future<Map<String, dynamic>?> Function(String name, Color colorCode) onSubmit;

  @override
  State<LabelForm> createState() => _LabelFormState();
}

class _LabelFormState extends State<LabelForm> {
  String _name = '';
  Color _colorCode = labelColors.first.$1;
  String? _errorName;

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      _name = widget.initialValues!.name;
      _colorCode = widget.initialValues!.colorCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: widget.formKey,
      onSubmit: () async {
        setState(() {
          _errorName = null;
        });

        if (widget.formKey.currentState?.validate() == true) {
          widget.formKey.currentState?.save();
          final errors = await widget.onSubmit(_name, _colorCode);

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
        Wrap(
          spacing: 3,
          runSpacing: 3,
          alignment: WrapAlignment.start,
          children: labelColors
              .map(
                (color) => _colorCode == color.$1
                    ? IconButton.outlined(
                        onPressed: () {},
                        tooltip: color.$2,
                        icon: Icon(Icons.circle_rounded, color: color.$1),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _colorCode = color.$1;
                          });
                        },
                        tooltip: color.$2,
                        icon: Icon(Icons.circle_rounded, color: color.$1),
                      ),
              )
              .toList(),
        ),
      ],
    );
  }
}
