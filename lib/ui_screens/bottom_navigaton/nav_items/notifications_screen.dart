import 'package:flutter/material.dart';

import '../../../utils/app_colours.dart';

class NotificationScreen extends StatefulWidget {
  static const String key_title = '/notification';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> _values = [
      'One Notification description here',
      'Two Notification description here',
      'Three Notification description here',
      'Four Notification description here',
      'Five Notification description here',
      'Six Notification description here',
      'Seven Notification description here',
      'Eight Notification description here',
      'Nine Notification description here'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: AppColours.colorOnPrimary,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: ListView.separated(
          itemCount: _values.length,
          padding: const EdgeInsets.all(5.0),
          separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  print("Mark as Read");
                } else {
                  print('Remove Notification');
                }

                setState(() {
                  _values.removeAt(index);
                });
              },
              child: ListTile(
                leading: Icon(Icons.circle_notifications_outlined,
                    size: 40, color: AppColours.colorPrimary),
                title: Text(_values[index]),
                subtitle: Text('Description here'),
                trailing: Icon(Icons.more_horiz),
              ),
            );
          }),
    );
  }
}
