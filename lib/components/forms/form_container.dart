import 'dart:async';

import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../loading_overlay.dart';

class FormContainer extends StatefulWidget {
  const FormContainer({
    super.key,
    required this.formKey,
    this.errorText,
    this.padding,
    this.width,
    required this.fields,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final String? errorText;
  final EdgeInsets? padding;
  final double? width;
  final List<Widget> fields;
  final FutureOr<String?> Function() onSubmit;

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  String? _errorText;

  Future<void> _onSubmit() async {
    LoadingOverlay loadingOverlay = showLoadingOverlay(context);
    String? errorText;

    try {
      if (widget.formKey.currentState?.validate() == true) {
        widget.formKey.currentState?.save();

        errorText = await widget.onSubmit();
      } else {
        errorText = context.l10n.pleaseCheckTheHighlightedFields;
      }
    } catch (e) {
      if (mounted) {
        errorText = context.l10n.somethingWentWrong;
      }
    } finally {
      setState(() {
        _errorText = errorText;
      });

      loadingOverlay.hide();
    }
  }

  @override
  void initState() {
    super.initState();

    _errorText = widget.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width ?? 640,
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children:
              <Widget>[
                if (_errorText != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.errorContainer,
                      ),
                      child: Row(
                        spacing: 12,
                        children: [
                          const Icon(Icons.error_rounded),
                          Expanded(
                            child: Text(
                              _errorText!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ] +
              widget.fields +
              [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(onPressed: _onSubmit, child: Text(context.l10n.submit.toUpperCase())),
                ),
              ],
        ),
      ),
    );
  }
}
