import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  static const routeName = '/event-detail';
  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Container(
        child: Column(
          children: [Text(eventId)],
        ),
      ),
    );
  }
}
