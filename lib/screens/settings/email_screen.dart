import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../components/screen_title.dart';
import '../../components/scrollable_dialog.dart';
import '../../graphql/mutations/update_email.graphql.dart';
import '../../graphql/queries/current_user_email.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../not_found_screen.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.emailSettings;

    return Query$CurrentUserEmail$Widget(
      builder: (result, {fetchMore, refetch}) => QueryResultBuilder(
        result: result,
        refetch: refetch,
        noResultWidget: const NotFoundScreen(),
        buildIf: (parsedData) => parsedData?.currentUser != null,
        builder: (parsedData) => ScreenTitle(
          title: title,
          child: Scaffold(
            appBar: AppBar(title: Text(title)),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(context.l10n.currentEmail, style: TextTheme.of(context).titleMedium),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          parsedData.currentUser!.email,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        parsedData.currentUser!.emailIsConfirmed
                            ? Chip(label: Text(context.l10n.confirmed))
                            : OutlinedButton(
                                onPressed: () => showEmailConfirmationDialog(context),
                                child: Text(context.l10n.sendConfirmationCode),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(context.l10n.editEmail, style: TextTheme.of(context).titleMedium),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: _EditEmailForm()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EditEmailForm extends StatefulWidget {
  @override
  _EditEmailFormState createState() => _EditEmailFormState();
}

class _EditEmailFormState extends State<_EditEmailForm> {
  final _formPasswordValidation = GlobalKey<FormState>();
  final _formEditEmail = GlobalKey<FormState>();

  String _password = '';
  String _email = '';
  String? _errorEmail;

  Future<String?> _onPasswordValidationSubmit() async {
    context.pop();

    final result = await context.graphQLClient.mutate$UpdateEmail(
      Options$Mutation$UpdateEmail(
        variables: Variables$Mutation$UpdateEmail(
          password: _password,
          params: Input$UpdateEmailParams(email: _email),
        ),
      ),
    );

    if (!mounted) {
      return null;
    }

    if (result.parsedData?.updateEmail != null) {
      showEmailConfirmationDialog(context).then((success) {
        if (success == true) {
          _formEditEmail.currentState?.reset();
        }
      });
    } else {
      final errors = result.exception?.graphqlErrors.first;

      setState(() {
        _errorEmail = errors?.extensions?['params']['email']?['message'];
      });

      return errors?.message ?? context.l10n.failedToUpdateEmail;
    }

    return null;
  }

  String? _onEditEmailSubmit() {
    showDialog(
      context: context,
      builder: (context) => ScrollableDialog(
        title: Text(context.l10n.enterYourPassword),
        width: 480,
        child: FormContainer(
          formKey: _formPasswordValidation,
          onSubmit: _onPasswordValidationSubmit,
          fields: [
            PasswordInputField(
              required: true,
              autofillHints: const [AutofillHints.password],
              onSaved: (value) {
                _password = value ?? '';
              },
            ),
          ],
        ),
      ),
    );

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      onSubmit: _onEditEmailSubmit,
      formKey: _formEditEmail,
      fields: [
        TextInputField(
          labelText: context.l10n.email,
          errorText: _errorEmail,
          required: true,
          autofillHints: const [AutofillHints.email],
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) {
            _email = value ?? '';
          },
        ),
      ],
    );
  }
}
