import 'package:flutter/material.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../session_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLogin = GlobalKey<FormState>();

  String _usernameOrEmail = '';
  String _password = '';
  String? _errorUsernameOrEmail;
  String? _errorPassword;

  void _attemptToLogin() async {
    setState(() {
      _errorUsernameOrEmail = null;
      _errorPassword = null;
    });

    if (_formLogin.currentState?.validate() == true) {
      _formLogin.currentState?.save();
      final result = await SessionManager.attemptToLogin(
        context,
        usernameOrEmail: _usernameOrEmail,
        password: _password,
      );

      if (!mounted) {
        return;
      }

      final errors = result.exception?.graphqlErrors.first;

      if (errors != null) {
        showSnackBarAlert(context, errors.message);

        setState(() {
          _errorUsernameOrEmail = errors.extensions?['params']['usernameOrEmail']?['message'];
          _errorPassword = errors.extensions?['params']['password']?['message'];
        });
      }
    } else {
      showSnackBarAlert(context, 'Failed to create session');
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.login;

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
                  formKey: _formLogin,
                  onSubmit: _attemptToLogin,
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
                    PasswordInputField(
                      errorText: _errorPassword,
                      required: true,
                      autofillHints: const [AutofillHints.password],
                      onSaved: (value) {
                        _password = value ?? '';
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 640,
                  child: TextButton(
                    onPressed: () => context.router.goToRegister(),
                    child: Text(context.l10n.iDontHaveAnAccount),
                  ),
                ),
                SizedBox(
                  width: 640,
                  child: TextButton(
                    onPressed: () => context.router.goToResetPassword(),
                    child: Text(context.l10n.iForgotMyPassword),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
