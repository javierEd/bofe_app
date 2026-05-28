import 'package:flutter/material.dart';

extension ValueKeys on ValueKey<String> {
  static ValueKey<String> card(String id) => ValueKey('card-$id');
}
