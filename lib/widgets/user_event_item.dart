import 'package:bit_connect/providers/events.dart';
import 'package:bit_connect/screens/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEventItem extends StatelessWidget {
  final String eid;
  final String title;
  UserEventItem(this.eid, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(title),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditEventScreen.routeName, arguments: eid);
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<Events>(context, listen: false)
                        .deleteEvent(eid);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
