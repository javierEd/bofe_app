import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../graphql/fragments/user_fragment.graphql.dart';

class UserAvatarImage extends CircleAvatar {
  UserAvatarImage({super.key, required Fragment$UserFragment user, double size = 24})
    : super(
        radius: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: CachedNetworkImage(
            imageUrl: user.avatarImageUrl.replace(queryParameters: {'size': '128'}).toString(),
            placeholder: (context, url) => Text(user.initials, style: TextStyle(fontSize: size)),
          ),
        ),
      );
}

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user, this.onTap});

  final Fragment$UserFragment user;
  final Function()? onTap;

  Row _getUserItem() {
    return Row(
      spacing: 6,
      children: [
        UserAvatarImage(size: 16, user: user),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user.displayName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('@${user.username}', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
        onTap: onTap,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: _getUserItem()),
      );
    }

    return _getUserItem();
  }
}
