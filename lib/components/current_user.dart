import 'package:flutter/material.dart';

import '../graphql/fragments/user_fragment.graphql.dart';
import '../graphql/queries/current_user.graphql.dart';

class CurrentUser extends StatelessWidget {
  const CurrentUser({super.key, required this.builder});

  final Widget Function(Fragment$UserFragment? user) builder;

  @override
  Widget build(BuildContext context) {
    return Query$CurrentUser$Widget(
      builder: (result, {fetchMore, refetch}) {
        final user = result.parsedData?.currentUser;

        return builder(user);
      },
    );
  }
}
