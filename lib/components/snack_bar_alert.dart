import 'package:flutter/material.dart';

import '../build_context.dart';

void showSnackBarAlert(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      action: SnackBarAction(label: context.l10n.close, onPressed: () => {}),
      duration: const Duration(seconds: 5),
      persist: false,
    ),
  );
}
