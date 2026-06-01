import 'package:flutter/material.dart';

void showSnackBarAlert(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      action: SnackBarAction(label: 'Close', onPressed: () => {}),
      duration: const Duration(seconds: 5),
      persist: false,
    ),
  );
}
