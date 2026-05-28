import 'package:flutter/material.dart';

class ValueKeys {
  static ValueKey<String> board(String slug) => ValueKey('board_$slug');

  static ValueKey<String> card(String id) => ValueKey('card_$id');

  static ValueKey<String> editCard(String id) => ValueKey('edit_card_$id');
}
