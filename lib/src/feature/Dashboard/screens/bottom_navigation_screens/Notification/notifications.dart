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
    {
      'type': 'clickable',
      'title': 'New Friend Request',
      'body': 'John Doe sent you a friend request.',
      'navigateTo': '/friend_request',
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
          } else if (notification['type'] == 'clickable') {
            return buildClickableNotification(notification);
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
          // Handle delete action
          setState(() {
            notifications.remove(notification);
          });
        },
      ),
    );
  }

  Widget buildClickableNotification(dynamic notification) {
    bool highlightClicked = false;

    return ListTile(
      title: Text(notification['title'] as String),
      subtitle: Row(
        children: [
          Text(notification['body'] as String),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                highlightClicked = !highlightClicked;
              });
            },
            child: Text(
              'Click Here',
              style: TextStyle(
                color: highlightClicked ? Colors.blueAccent : Colors.blue,
                decoration: highlightClicked ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
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
