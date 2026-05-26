import 'package:flutter/material.dart';

import '../graphql/fragments/user_fragment.graphql.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final Fragment$UserFragment user;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        CircleAvatar(radius: 16, child: Text(user.initials, style: TextStyle(fontSize: 14))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.displayName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('@${user.username}', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
