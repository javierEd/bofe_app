import 'package:flutter/material.dart';
import 'package:world_info_plus/world_info_plus.dart';

import '../graphql/schema.graphql.dart';
import 'dropdown_search_field.dart';

class CountryDropdownField extends DropdownSearchField<(Enum$CountryCode, Country?)> {
  CountryDropdownField({
    super.key,
    super.errorText,
    super.required,
    Enum$CountryCode? initialValue,
    required ValueChanged<Enum$CountryCode?> onSaved,
  }) : super(
         labelText: 'Country',
         searchDelay: Duration.zero,
         initialValue: initialValue != null
             ? (initialValue, WorldInfoPlus.getCountryByAlpha2(initialValue.name))
             : null,
         compareFn: (item1, item2) => item1.$1 == item2.$1,
         itemAsString: (item) => item.$2!.name,
         dropdownBuilder: (context, item) {
           if (item == null) {
             return SizedBox();
           }

           return Row(
             spacing: 12,
             children: [
               Image.asset(item.$2!.imagePath, height: 24, width: 32, fit: BoxFit.cover),
               Text(item.$2!.name),
             ],
           );
         },
         itemBuilder: (context, item, isDisabled, isSelected) => Padding(
           padding: EdgeInsets.all(12),
           child: Row(
             spacing: 12,
             children: [
               Image.asset(item.$2!.imagePath, height: 24, width: 32, fit: BoxFit.cover),
               Text(item.$2!.name),
               Spacer(),
               if (isSelected) Icon(Icons.check_rounded),
             ],
           ),
         ),
         items: (filter, loadProps) => Enum$CountryCode.values
             .map((code) => (code, WorldInfoPlus.getCountryByAlpha2(code.name)))
             .where((item) => item.$2 != null && item.$1 != Enum$CountryCode.$unknown)
             .toList(),
         onSaved: (item) => onSaved(item?.$1),
       );
}
