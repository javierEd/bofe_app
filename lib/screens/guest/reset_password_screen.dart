import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../components/screen_title.dart';
import '../../components/scrollable_dialog.dart';
import '../../graphql/mutations/confirm_password_reset.graphql.dart';
import '../../graphql/mutations/send_password_reset_confirmation.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql_client.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formResetPassword = GlobalKey<FormState>();

  String _usernameOrEmail = '';
  String? _errorUsernameOrEmail;

  Future<String?> _attemptToSendConfirmation() async {
    setState(() {
      _errorUsernameOrEmail = null;
    });

    final result = await context.graphQLClient.mutate$SendPasswordResetConfirmation(
      Options$Mutation$SendPasswordResetConfirmation(
        variables: Variables$Mutation$SendPasswordResetConfirmation(
          params: Input$ResetPasswordParams(usernameOrEmail: _usernameOrEmail),
        ),
      ),
    );

    if (!mounted) {
      return null;
    }

    final confirmationSent = result.parsedData?.sendPasswordResetConfirmation;

    if (confirmationSent != null) {
      _showConfirmationDialog(confirmationSent.id);
    } else {
      setState(() {
        _errorUsernameOrEmail = result.getParamError('usernameOrEmail');
      });

      return result.errorMessage ?? context.l10n.failedToSendConfirmation;
    }

    return null;
  }

  Future<dynamic> _showConfirmationDialog(String confirmationId) {
    return showDialog(
      context: context,
      builder: (context) => _PasswordResetConfirmationDialog(confirmationId: confirmationId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.resetPassword;
    return ScreenTitle(
      title: title,
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              spacing: 12,
              children: [
                FormContainer(
                  formKey: _formResetPassword,
                  onSubmit: _attemptToSendConfirmation,
                  fields: [
                    TextInputField(
                      labelText: context.l10n.usernameOrEmail,
                      errorText: _errorUsernameOrEmail,
                      required: true,
                      autofillHints: const [AutofillHints.username],
                      maxLines: 1,
                      onSaved: (value) {
                        _usernameOrEmail = value ?? '';
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 640,
                  child: TextButton(onPressed: () => context.router.goToLogin(), child: Text(context.l10n.backToLogin)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordResetConfirmationDialog extends StatefulWidget {
  const _PasswordResetConfirmationDialog({required this.confirmationId});

  final String confirmationId;

  @override
  State<_PasswordResetConfirmationDialog> createState() => _PasswordResetConfirmationDialogState();
}

class _PasswordResetConfirmationDialogState extends State<_PasswordResetConfirmationDialog> {
  final _formConfirmPasswordReset = GlobalKey<FormState>();

  String _code = '';

  Future<String?> _attemptToConfirmPasswordReset() async {
    final result = await context.graphQLClient.mutate$ConfirmPasswordReset(
      Options$Mutation$ConfirmPasswordReset(
        variables: Variables$Mutation$ConfirmPasswordReset(
          confirmationParams: Input$ConfirmationParams(id: widget.confirmationId, code: _code),
        ),
      ),
    );
    final confirmed = result.parsedData?.confirmPasswordReset;

    if (!mounted) {
      return null;
    }

    if (confirmed != null) {
      showSnackBarAlert(context, context.l10n.passwordResetConfirmedSuccessfully);

      context.router.goToLogin();
    } else {
      return result.errorMessage ?? context.l10n.failedToConfirmPasswordReset;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      title: Text(context.l10n.confirmPasswordReset),
      width: 480,
      child: FormContainer(
        formKey: _formConfirmPasswordReset,
        onSubmit: _attemptToConfirmPasswordReset,
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
      ),
    );
  }
}
