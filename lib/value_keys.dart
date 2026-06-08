import 'package:flutter/material.dart';

class ValueKeys {
  static ValueKey<String> board(String username, String slug) => ValueKey('board:$username:$slug');

  static ValueKey<String> boardContext(String username, String slug) => ValueKey('board_context:$username:$slug');

  static ValueKey<String> card(String id) => ValueKey('card:$id');

  static ValueKey<String> editLabel(String id) => ValueKey('edit_label:$id');

  static ValueKey<String> labels(String username, String slug) => ValueKey('labels:$username:$slug');

  static ValueKey<String> members(String username, String slug) => ValueKey('members:$username:$slug');

  static ValueKey<String> user(String username) => ValueKey('user:$username');
}
