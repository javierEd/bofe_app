import 'package:bofe/components/user_item.dart';
import 'package:flutter/material.dart';

import '../../build_context.dart';
import '../../components/screen_title.dart';
import '../../constants.dart';
import '../../sessions_manager.dart';

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({super.key});

  @override
  State<SwitchAccountScreen> createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final title = context.l10n.switchAccount;

    return ScreenTitle(
      title: title,
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: FutureBuilder(
              future: SessionsManager.readSessions(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final sessions = snapshot.data!;

                  return Column(
                    spacing: 12,
                    children:
                        sessions.list
                            .map(
                              (session) => InkWell(
                                onTap: (session.id == SessionsManager.current?.id)
                                    ? null
                                    : () => SessionsManager.switchSession(session),
                                child: Container(
                                  width: 480,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: borderRadius,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      UserItem(user: session.user),
                                      if (session.id == SessionsManager.current?.id) Icon(Icons.check_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList() +
                        [
                          InkWell(
                            onTap: () => context.router.goToLogin(),
                            child: Container(
                              width: 480,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: borderRadius,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Icon(Icons.person_add_rounded), Text(context.l10n.addAccount)],
                              ),
                            ),
                          ),
                        ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
