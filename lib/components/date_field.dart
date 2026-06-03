import 'package:flutter/material.dart';

import 'text_input_field.dart';

class DateField extends StatefulWidget {
  const DateField({
    super.key,
    this.labelText,
    this.errorText,
    this.required = false,
    this.initialValue,
    required this.onSaved,
  });

  final String? labelText;
  final String? errorText;
  final bool required;
  final DateTime? initialValue;
  final void Function(DateTime?) onSaved;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final _controller = TextEditingController();
  DateTime? _value;

  @override
  initState() {
    super.initState();

    if (widget.initialValue != null) {
      _value = widget.initialValue;
      _controller.text = widget.initialValue!.toLocal().toString().split(' ')[0];
    }
  }

  @override
  didUpdateWidget(covariant DateField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
      _controller.text = widget.initialValue?.toLocal().toString().split(' ')[0] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      controller: _controller,
      labelText: widget.labelText,
      errorText: widget.errorText,
      required: widget.required,
      suffixIcon: Icon(Icons.calendar_today_rounded),
      readOnly: true,
      onSaved: (_) => widget.onSaved(_value),
      onTap: () async {
        final value = await showDatePicker(
          context: context,
          initialDate: _value,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (widget.required && value == null) {
          return;
        }

        _value = value;
        _controller.text = value?.toLocal().toString().split(' ')[0] ?? '';
      },
    );
  }
}
