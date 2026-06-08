import 'package:flutter/material.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/date_field.dart';
import '../components/form_container.dart';
import '../components/password_input_field.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../components/text_input_field.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/mutations/create_user.graphql.dart';
import '../session_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formRegister = GlobalKey<FormState>();

  String _username = '';
  String _email = '';
  String _password = '';
  String _fullName = '';
  DateTime? _birthdate;
  Enum$CountryCode? _countryCode;
  String? _errorUsername;
  String? _errorEmail;
  String? _errorPassword;
  String? _errorFullName;
  String? _errorBirthdate;
  String? _errorCountryCode;

  void _attemptToCreateUser() async {
    setState(() {
      _errorUsername = null;
      _errorEmail = null;
      _errorPassword = null;
      _errorFullName = null;
      _errorBirthdate = null;
      _errorCountryCode = null;
    });

    if (_formRegister.currentState?.validate() == true) {
      _formRegister.currentState?.save();
      final result = await context.graphQLClient.mutate$CreateUser(
        Options$Mutation$CreateUser(
          variables: Variables$Mutation$CreateUser(
            params: Input$UserParams(
              username: _username,
              email: _email,
              password: _password,
              fullName: _fullName,
              birthdate: _birthdate,
              countryCode: _countryCode!,
            ),
          ),
        ),
      );

      if (!mounted) {
        return;
      }

      final errors = result.exception?.graphqlErrors.first;

      if (result.parsedData?.createUser != null) {
        await SessionManager.attemptToLogin(context, usernameOrEmail: _username, password: _password);
      } else {
        showSnackBarAlert(context, errors?.message ?? 'Failed to create user');

        setState(() {
          _errorUsername = errors?.extensions?['params']['username']?['message'];
          _errorEmail = errors?.extensions?['params']['email']?['message'];
          _errorPassword = errors?.extensions?['params']['password']?['message'];
          _errorFullName = errors?.extensions?['params']['fullName']?['message'];
          _errorBirthdate = errors?.extensions?['params']['birthdate']?['message'];
          _errorCountryCode = errors?.extensions?['params']['countryCode']?['message'];
        });
      }
    } else {
      showSnackBarAlert(context, 'Failed to create user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTitle(
      title: 'Register',
      child: Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: FormContainer(
              formKey: _formRegister,
              onSubmit: _attemptToCreateUser,
              fields: [
                TextInputField(
                  labelText: 'Username',
                  errorText: _errorUsername,
                  required: true,
                  maxLines: 1,
                  onSaved: (value) {
                    _username = value ?? '';
                  },
                ),
                TextInputField(
                  labelText: 'Email',
                  errorText: _errorEmail,
                  required: true,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                ),
                PasswordInputField(
                  errorText: _errorPassword,
                  required: true,
                  onSaved: (value) {
                    _password = value ?? '';
                  },
                ),
                TextInputField(
                  labelText: 'Full name',
                  errorText: _errorFullName,
                  required: true,
                  maxLines: 1,
                  onSaved: (value) {
                    _fullName = value ?? '';
                  },
                ),
                DateField(
                  labelText: 'Birthdate',
                  errorText: _errorBirthdate,
                  required: true,
                  onSaved: (value) {
                    _birthdate = value;
                  },
                ),
                CountryField(errorText: _errorCountryCode, required: true, onSaved: (value) => _countryCode = value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
