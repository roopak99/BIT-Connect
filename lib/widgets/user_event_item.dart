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
    final snackScaffold = Scaffold.of(context);
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
                  onPressed: () async {
                    try {
                      await Provider.of<Events>(context, listen: false)
                          .deleteEvent(eid);
                    } catch (error) {
                      // ignore: deprecated_member_use
                      snackScaffold.showSnackBar(SnackBar(
                          content: Text(
                        'Deletion Failed',
                        textAlign: TextAlign.center,
                      )));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
