import 'package:flutter/material.dart';

class MySessionsScreen extends StatefulWidget {
  const MySessionsScreen({Key? key}) : super(key: key);

  @override
  State<MySessionsScreen> createState() => _MySessionsScreenState();
}

class _MySessionsScreenState extends State<MySessionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("MySessionsScreen"),
    );
  }
}
