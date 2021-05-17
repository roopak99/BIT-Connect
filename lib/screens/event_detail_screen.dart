import 'package:bit_connect/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetail extends StatelessWidget {
  static const routeName = '/event-detail';
  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context).settings.arguments as String;
    final loadedEvent =
        Provider.of<Events>(context, listen: false).findById(eventId);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(loadedEvent.title),
        ),
        body: Text('hi'));
  }
}
