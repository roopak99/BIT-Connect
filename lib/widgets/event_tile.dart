import 'package:bit_connect/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final String eid;
  final String title;
  final DateTime eventDate;
  final String branch;
  final String batch;

  EventTile({
    @required this.eid,
    @required this.title,
    @required this.eventDate,
    @required this.branch,
    @required this.batch,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        trailing: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              VerticalDivider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    branch,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    batch,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              VerticalDivider(),
              Text(
                DateFormat('dd MMM yy').format(eventDate),
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(EventDetail.routeName, arguments: eid);
        },
      ),
    );
  }
}
