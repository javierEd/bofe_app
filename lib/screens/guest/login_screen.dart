import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../components/screen_title.dart';
import '../../graphql_client.dart';
import '../../session_manager.dart';

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

  Future<String?> _attemptToLogin() async {
    final result = await SessionManager.attemptToLogin(context, usernameOrEmail: _usernameOrEmail, password: _password);

    if (!mounted) {
      return null;
    }

    if (result.hasErrors) {
      setState(() {
        _errorUsernameOrEmail = result.getParamError('usernameOrEmail');
        _errorPassword = result.getParamError('password');
      });

      return result.errorMessage;
    }

    return null;
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
