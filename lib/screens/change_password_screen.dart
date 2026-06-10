import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/form_container.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../graphql/mutations/update_password.graphql.dart';
import '../graphql/schema.graphql.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formChangePassword = GlobalKey<FormState>();

  String _currentPassword = '';
  String _newPassword = '';
  String? _errorCurrentPassword;
  String? _errorNewPassword;

  Future<void> _attemptToChangePassword() async {
    setState(() {
      _errorCurrentPassword = null;
      _errorNewPassword = null;
    });

    if (_formChangePassword.currentState?.validate() == true) {
      _formChangePassword.currentState?.save();
      final result = await context.graphQLClient.mutate$UpdatePassword(
        Options$Mutation$UpdatePassword(
          variables: Variables$Mutation$UpdatePassword(
            params: Input$UpdatePasswordParams(currentPassword: _currentPassword, newPassword: _newPassword),
          ),
        ),
      );

      if (!mounted) {
        return;
      }

      if (result.parsedData?.updatePassword != null) {
        showSnackBarAlert(context, 'Password updated successfully');
        context.pop();
      } else {
        final errors = result.exception?.graphqlErrors.first;

        showSnackBarAlert(context, errors?.message ?? 'Failed to update password');

        setState(() {
          _errorCurrentPassword = errors?.extensions?['params']['currentPassword']?['message'];
          _errorNewPassword = errors?.extensions?['params']['newPassword']?['message'];
        });
      }
    } else {
      showSnackBarAlert(context, 'Failed to update password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTitle(
      title: 'Change Password',
      child: Scaffold(
        appBar: AppBar(title: const Text('Change Password')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: FormContainer(
              formKey: _formChangePassword,
              onSubmit: _attemptToChangePassword,
              fields: [
                PasswordInputField(
                  labelText: 'Current password',
                  errorText: _errorCurrentPassword,
                  required: true,
                  autofillHints: const [AutofillHints.password],
                  onSaved: (value) {
                    _currentPassword = value ?? '';
                  },
                ),
                PasswordInputField(
                  errorText: _errorNewPassword,
                  required: true,
                  autofillHints: const [AutofillHints.newPassword],
                  onSaved: (value) {
                    _newPassword = value ?? '';
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
