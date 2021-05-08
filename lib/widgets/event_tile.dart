import 'package:bit_connect/screens/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final String eid;
  final String title;
  final DateTime eventDate;

  EventTile({
    @required this.eid,
    @required this.title,
    @required this.eventDate,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Text(
          DateFormat('dd MMM yy').format(eventDate),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_off_outlined),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(EventDetail.routeName, arguments: eid);
        },
      ),
    );
  }
}
