import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../scrollable_dialog.dart';

class SelectField<T> extends StatelessWidget {
  SelectField({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    T? initialValue,
    this.required = false,
    required this.filterFn,
    required this.options,
    required this.optionBuilder,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
  }) : initialValue = _initialValueToMulti(initialValue),
       onSaved = _onSavedToMulti(onSaved),
       validator = _validatorToMulti(validator),
       isMulti = false;

  const SelectField.multi({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.initialValue = const [],
    this.required = false,
    required this.filterFn,
    required this.options,
    required this.optionBuilder,
    this.onSaved,
    this.validator,
  }) : isMulti = true;

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final List<T> initialValue;
  final bool required;
  final bool Function(T, String) filterFn;
  final List<T> options;
  final Widget Function(T) optionBuilder;
  final FormFieldSetter<List<T>>? onSaved;
  final FormFieldValidator<List<T>>? validator;
  final bool isMulti;

  static List<T> _initialValueToMulti<T>(T? value) {
    return [?value];
  }

  static FormFieldSetter<List<T>>? _onSavedToMulti<T>(FormFieldSetter<T>? onSaved) {
    return (value) => onSaved?.call(value?.first);
  }

  static FormFieldValidator<List<T>>? _validatorToMulti<T>(FormFieldValidator<T>? validator) {
    return (value) => validator?.call(value?.first);
  }

  Future<List<T>?> _showDialog(BuildContext context, FormFieldState<List<T>> state) async {
    return await showDialog<List<T>?>(
      context: context,
      builder: (context) => _SelectDialog(
        options: options,
        selected: state.value,
        filterFn: filterFn,
        optionBuilder: optionBuilder,
        isMulti: isMulti,
      ),
    );
  }

  String? _validator(BuildContext context, List<T>? value) {
    if (required && value?.isNotEmpty != true) {
      return 'Can\'t be blank';
    }

    return validator?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (value) => _validator(context, value),
      builder: (state) => InkWell(
        borderRadius: borderRadius,
        onTap: () async {
          final selected = await _showDialog(context, state) ?? state.value;

          if (context.mounted) {
            state.didChange(selected);
          }
        },
        child: InputDecorator(
          isEmpty: state.value?.isNotEmpty != true,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            errorText: errorText,
            suffixIcon: Icon(Icons.arrow_outward_rounded),
          ),
          child: state.value?.isNotEmpty == true
              ? Wrap(spacing: 4, runSpacing: 4, children: state.value?.map(optionBuilder).toList() ?? [])
              : null,
        ),
      ),
    );
  }
}

class _SelectDialog<T> extends StatefulWidget {
  const _SelectDialog({
    required this.options,
    required this.selected,
    required this.filterFn,
    required this.optionBuilder,
    required this.isMulti,
  });

  final List<T> options;
  final List<T>? selected;
  final bool Function(T option, String filter) filterFn;
  final Widget Function(T option) optionBuilder;
  final bool isMulti;

  @override
  State<_SelectDialog<T>> createState() => _SelectDialogState();
}

class _SelectDialogState<T> extends State<_SelectDialog<T>> {
  String _filter = '';
  List<T> _selected = [];

  void _toggleSelected(T option) {
    setState(() {
      if (_selected.contains(option) == true) {
        _selected.remove(option);
      } else {
        _selected.add(option);
      }
    });
  }

  Widget _getOptions() {
    final filteredOptions = widget.options.where((option) => widget.filterFn(option, _filter));

    if (widget.isMulti) {
      return Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filteredOptions
            .map(
              (option) => InkWell(
                onTap: () {
                  _toggleSelected(option);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    spacing: 2,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.optionBuilder(option),
                      IgnorePointer(
                        child: Checkbox(onChanged: (_) {}, value: _selected.contains(option)),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return RadioGroup(
        onChanged: (_) {},
        groupValue: _selected.first,
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: filteredOptions
              .map(
                (option) => InkWell(
                  onTap: () => context.pop([option]),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      spacing: 2,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.optionBuilder(option),
                        IgnorePointer(child: Radio(value: option)),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      _selected = widget.selected!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      width: 480,
      child: Column(
        spacing: 8,
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Search...', suffixIcon: Icon(Icons.search_rounded)),
            onChanged: (value) {
              setState(() {
                _filter = value;
              });
            },
          ),
          _getOptions(),
          if (widget.isMulti)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () => context.pop(_selected), child: Text('OK')),
            ),
        ],
      ),
    );
  }
}
