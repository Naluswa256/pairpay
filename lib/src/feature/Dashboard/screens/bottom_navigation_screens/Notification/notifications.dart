// ignore_for_file: dead_code

import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<dynamic> notifications = [
    {
      'type': 'basic',
      'title': 'New Message',
      'body': 'You have a new message from John Doe.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Activity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          dynamic notification = notifications[index];
          if (notification['type'] == 'basic') {
            return buildBasicNotification(notification);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget buildBasicNotification(dynamic notification) {
    return ListTile(
      title: Text(notification['title'] as String),
      subtitle: Text(notification['body'] as String),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            notifications.remove(notification);
          });
        },
      ),
    );
  }
}
