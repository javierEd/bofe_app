import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../components.dart';
import '../components/date_field.dart';
import '../components/form_container.dart';
import '../components/query_result_builder.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../components/text_input_field.dart';
import '../graphql/mutations/update_profile.graphql.dart';
import '../graphql/queries/current_user_profile.graphql.dart';
import '../graphql/schema.graphql.dart';
import 'not_found_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formEditProfile = GlobalKey<FormState>();

  String _displayName = '';
  String _fullName = '';
  DateTime? _birthdate;
  Enum$CountryCode? _countryCode;
  String? _errorDisplayName;
  String? _errorFullName;
  String? _errorBirthdate;
  String? _errorCountryCode;

  Future<void> _attemptToUpdateProfile() async {
    setState(() {
      _errorDisplayName = null;
      _errorFullName = null;
      _errorBirthdate = null;
      _errorCountryCode = null;
    });

    if (_formEditProfile.currentState?.validate() == true) {
      _formEditProfile.currentState?.save();

      final result = await context.graphQLClient.mutate$UpdateProfile(
        Options$Mutation$UpdateProfile(
          variables: Variables$Mutation$UpdateProfile(
            params: Input$UpdateProfileParams(
              displayName: _displayName,
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

      if (result.parsedData?.updateProfile != null) {
        showSnackBarAlert(context, 'Profile updated successfully');
        context.pop();
      } else {
        final errors = result.exception?.graphqlErrors.first;

        showSnackBarAlert(context, errors?.message ?? 'Failed to update profile');

        setState(() {
          _errorDisplayName = errors?.extensions?['params']['displayName']?['message'];
          _errorFullName = errors?.extensions?['params']['fullName']?['message'];
          _errorBirthdate = errors?.extensions?['params']['birthdate']?['message'];
          _errorCountryCode = errors?.extensions?['params']['countryCode']?['message'];
        });
      }
    } else {
      showSnackBarAlert(context, 'Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Query$CurrentUserProfile$Widget(
      builder: (result, {fetchMore, refetch}) => QueryResultBuilder(
        result: result,
        refetch: refetch,
        noResultWidget: const NotFoundScreen(),
        buildIf: (parsedData) => parsedData?.currentUser != null,
        builder: (parsedData) => ScreenTitle(
          title: 'Edit Profile',
          child: Scaffold(
            appBar: AppBar(title: const Text('Edit Profile')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: FormContainer(
                  formKey: _formEditProfile,
                  onSubmit: _attemptToUpdateProfile,
                  fields: [
                    TextInputField(
                      labelText: 'Display name',
                      errorText: _errorDisplayName,
                      required: true,
                      maxLines: 1,
                      initialValue: parsedData.currentUser?.displayName,
                      onSaved: (value) {
                        _displayName = value ?? '';
                      },
                    ),
                    TextInputField(
                      labelText: 'Full name',
                      errorText: _errorFullName,
                      required: true,
                      maxLines: 1,
                      initialValue: parsedData.currentUser?.fullName,
                      onSaved: (value) {
                        _fullName = value ?? '';
                      },
                    ),
                    DateField(
                      labelText: 'Birthdate',
                      errorText: _errorBirthdate,
                      required: true,
                      initialValue: parsedData.currentUser?.birthdate,
                      onSaved: (value) {
                        _birthdate = value;
                      },
                    ),
                    CountryField(
                      errorText: _errorCountryCode,
                      required: true,
                      initialValue: parsedData.currentUser?.countryCode,
                      onSaved: (value) => _countryCode = value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
