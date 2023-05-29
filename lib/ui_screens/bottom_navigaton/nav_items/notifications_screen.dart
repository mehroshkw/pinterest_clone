import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const String key_title = '/notification';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notification"),
      ),
    );
  }
}
