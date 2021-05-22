import 'package:bit_connect/providers/events.dart';
import 'package:bit_connect/screens/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEventItem extends StatelessWidget {
  final String eid;
  final String title;
  UserEventItem(this.eid, this.title);

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Event"),
          content: new Text("Are you sure you want to delete the event?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            TextButton.icon(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();
                  await Provider.of<Events>(context, listen: false)
                      .deleteEvent(eid);
                } catch (error) {
                  showBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Text('Could not delete the event');
                    },
                  );
                }
              },
              icon: Icon(Icons.delete_rounded),
              label: Text('Okay'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.cancel_rounded),
              label: Text('Cancel'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

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
                    _showDialog(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
