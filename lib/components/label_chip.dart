import 'package:flutter/material.dart';

import '../graphql/fragments/label_fragment.graphql.dart';

class LabelChip extends Container {
  LabelChip({super.key, required Fragment$LabelFragment label})
    : super(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: label.colorCode),
        ),

        child: Text(
          label.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: label.colorCode),
        ),
      );
}
