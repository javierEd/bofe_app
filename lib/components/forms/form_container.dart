import 'dart:async';

import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../loading_overlay.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({
    super.key,
    required this.formKey,
    this.padding,
    this.width,
    required this.fields,
    this.showLoading = true,
    required this.onSubmit,
  });

  final List<Widget> fields;
  final GlobalKey<FormState> formKey;
  final EdgeInsets? padding;
  final double? width;
  final bool showLoading;
  final FutureOr<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width ?? 640,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children:
              fields +
              [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      LoadingOverlay? loadingOverlay;

                      if (showLoading) {
                        loadingOverlay = showLoadingOverlay(context);
                      }

                      await onSubmit();

                      loadingOverlay?.hide();
                    },
                    child: Text(context.l10n.submit.toUpperCase()),
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
