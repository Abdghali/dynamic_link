import 'package:flutter/material.dart';

class InvitationScreen extends StatefulWidget {
  String? title;
  InvitationScreen({Key? key, this.title}) : super(key: key);

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.title!)),
    );
  }
}
