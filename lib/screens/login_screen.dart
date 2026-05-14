import 'package:flutter/material.dart';

import '../components/form_container.dart';
import '../components/password_input_field.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../components/text_input_field.dart';
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
    return ScreenTitle(
      title: 'Login',
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: FormContainer(
              formKey: _formLogin,
              onSubmit: _attemptToLogin,
              fields: [
                TextInputField(
                  labelText: 'Username or email',
                  errorText: _errorUsernameOrEmail,
                  required: true,
                  maxLines: 1,
                  onSaved: (value) {
                    _usernameOrEmail = value ?? '';
                  },
                ),
                PasswordInputField(
                  errorText: _errorPassword,
                  required: true,
                  onSaved: (value) {
                    _password = value ?? '';
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
