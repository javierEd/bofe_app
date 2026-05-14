import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              context.goNamed(routeNameLogin);
            },
            icon: const Icon(Icons.login_rounded),
            label: const Text('Login'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              context.goNamed(routeNameRegister);
            },
            icon: const Icon(Icons.person_add_rounded),
            label: const Text('Register'),
          ),
        ),
      ],
    );
  }
}
