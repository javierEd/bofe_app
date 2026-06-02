import 'package:flutter/material.dart';

class ValueKeys {
  static ValueKey<String> board(String username, String slug) => ValueKey('board_${username}_$slug');

  static ValueKey<String> card(String id) => ValueKey('card_$id');

  static ValueKey<String> editCard(String id) => ValueKey('edit_card_$id');

  static ValueKey<String> members(String username, String slug) => ValueKey('members_${username}_$slug');

  static ValueKey<String> user(String username) => ValueKey('user_$username');
}
