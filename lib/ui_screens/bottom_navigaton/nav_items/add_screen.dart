import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  static const String key_title = '/add';

  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("add"),
      ),
    );
  }
}
