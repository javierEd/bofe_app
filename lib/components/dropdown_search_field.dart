import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownSearchField<T> extends StatelessWidget {
  const DropdownSearchField({
    super.key,
    this.labelText,
    this.errorText,
    this.initialValue,
    this.required = false,
    required this.compareFn,
    this.dropdownBuilder,
    this.itemAsString,
    this.itemBuilder,
    required this.items,
    required this.onSelected,
  });

  final String? labelText;
  final String? errorText;
  final DropdownSearchCompareFn<T> compareFn;
  final DropdownSearchBuilder<T>? dropdownBuilder;
  final T? initialValue;
  final bool required;
  final DropdownSearchItemAsString<T>? itemAsString;
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;
  final DropdownSearchOnFind<T> items;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
      popupProps: PopupProps.dialog(
        showSearchBox: true,
        dialogProps: const DialogProps(
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.all(16),
          barrierDismissible: true,
          barrierLabel: 'Close',
        ),
        itemBuilder: itemBuilder,
      ),
      selectedItem: initialValue,
      compareFn: compareFn,
      dropdownBuilder: dropdownBuilder,
      itemAsString: itemAsString,
      validator: (item) {
        if (required && item == null) {
          return 'Can\'t be blank';
        }

        return null;
      },
      onSelected: onSelected,
      items: (filter, loadProps) => items(filter.trim(), loadProps),
    );
  }
}
