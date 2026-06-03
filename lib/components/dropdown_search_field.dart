import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownSearchField<T> extends DropdownSearch<T> {
  DropdownSearchField({
    super.key,
    String? labelText,
    String? errorText,
    T? initialValue,
    bool required = false,
    Duration searchDelay = const Duration(milliseconds: 700),
    super.compareFn,
    super.dropdownBuilder,
    super.itemAsString,
    DropdownSearchPopupItemBuilder<T>? itemBuilder,
    super.items,
    super.onSaved,
  }) : super(
         decoratorProps: DropDownDecoratorProps(
           decoration: InputDecoration(
             labelText: labelText,
             errorText: errorText,
             border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
           ),
         ),
         popupProps: PopupProps.dialog(
           showSearchBox: true,
           searchFieldProps: TextFieldProps(
             decoration: InputDecoration(
               hintText: 'Search...',
               border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
               suffixIcon: const Icon(Icons.search_rounded),
             ),
           ),
           searchDelay: searchDelay,
           dialogProps: const DialogProps(
             titlePadding: EdgeInsets.all(16),
             contentPadding: EdgeInsets.all(16),
             barrierDismissible: true,
             barrierLabel: 'Close',
           ),
           itemBuilder: itemBuilder,
         ),
         selectedItem: initialValue,
         validator: (item) {
           if (required && item == null) {
             return 'Can\'t be blank';
           }

           return null;
         },
       );
}
