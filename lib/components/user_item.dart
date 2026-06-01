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

class UserItem extends Row {
  UserItem({super.key, required Fragment$UserFragment user})
    : super(
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
