// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class BasicNotificationWidget extends StatelessWidget {
  final String title;
  final String body;

  const BasicNotificationWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(title),
      subtitle: Text(body),
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.notifications),
      ),
    );
}
