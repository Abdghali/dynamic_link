import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  String? title;
  PostScreen({Key? key, this.title}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.title!)),
    );
  }
}
