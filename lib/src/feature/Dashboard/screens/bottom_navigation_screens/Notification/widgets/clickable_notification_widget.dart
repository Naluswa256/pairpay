import 'package:flutter/material.dart';

class ClickableNotificationWidget extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onTap;

  const ClickableNotificationWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        subtitle: Text(body),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.notifications_active),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
