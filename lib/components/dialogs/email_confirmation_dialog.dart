import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../build_context.dart';
import '../../graphql/mutations/confirm_email.graphql.dart';
import '../../graphql/mutations/send_email_confirmation.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../forms/form_container.dart';
import '../forms/text_input_field.dart';
import '../snackbar_alert.dart';
import '../scrollable_dialog.dart';

Future<bool?> showEmailConfirmationDialog(BuildContext context, {bool barrierDismissible = true}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => _EmailConfirmationDialog(barrierDismissible: barrierDismissible),
  );
}

class _EmailConfirmationDialog extends StatefulWidget {
  const _EmailConfirmationDialog({required this.barrierDismissible});

  final bool barrierDismissible;

  @override
  State<_EmailConfirmationDialog> createState() => _EmailConfirmationDialogState();
}

class _EmailConfirmationDialogState extends State<_EmailConfirmationDialog> {
  final _formConfirmEmail = GlobalKey<FormState>();

  Mutation$SendEmailConfirmation$sendEmailConfirmation? _emailConfirmation;
  String _code = '';

  void _attemptToConfirmEmail() async {
    if (_formConfirmEmail.currentState?.validate() == true) {
      _formConfirmEmail.currentState?.save();
      final result = await context.graphQLClient.mutate$ConfirmEmail(
        Options$Mutation$ConfirmEmail(
          variables: Variables$Mutation$ConfirmEmail(
            confirmationParams: Input$ConfirmationParams(id: _emailConfirmation!.id, code: _code),
          ),
        ),
      );
      final emailConfirmed = result.parsedData?.confirmEmail;

      if (!mounted) {
        return;
      }

      if (emailConfirmed != null) {
        showSnackBarAlert(context, context.l10n.emailConfirmedSuccessfully);

        context.pop(true);
      } else {
        final errors = result.exception?.graphqlErrors.first;

        showSnackBarAlert(context, errors?.message ?? context.l10n.failedToConfirmEmail);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await context.graphQLClient.mutate$SendEmailConfirmation();
      final emailConfirmation = result.parsedData?.sendEmailConfirmation;

      if (emailConfirmation != null) {
        setState(() {
          _emailConfirmation = emailConfirmation;
        });
      } else if (mounted) {
        final errors = result.exception?.graphqlErrors.first;

        showSnackBarAlert(context, errors?.message ?? context.l10n.failedToSendConfirmation);

        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      barrierDismissible: widget.barrierDismissible,
      title: Text(context.l10n.confirmYourEmail),
      width: 480,
      child: _emailConfirmation != null
          ? FormContainer(
              formKey: _formConfirmEmail,
              onSubmit: _attemptToConfirmEmail,
              fields: [
                Text(context.l10n.pleaseEnterTheCodeSentToYourEmail),
                TextInputField(
                  labelText: context.l10n.code,
                  keyboardType: TextInputType.name,
                  required: true,
                  onSaved: (value) {
                    setState(() {
                      _code = value ?? '';
                    });
                  },
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
