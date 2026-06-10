import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../components/screen_title.dart';
import '../../graphql/queries/current_user_email.graphql.dart';
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
                  Text('Current Email', style: TextTheme.of(context).titleMedium),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
