import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatarUrl;

  const ProfileAvatar({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: InkWell(
        radius: 20,
        onTap: () {},
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => CircleAvatar(
            backgroundImage: AssetImage("assets/images/default_profile.png"),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundImage: AssetImage("assets/images/default_profile.png"),
          ),
        ),
      ),
    );
  }
}
