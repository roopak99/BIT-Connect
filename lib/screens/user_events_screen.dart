import 'package:bit_connect/screens/edit_event_screen.dart';
import 'package:bit_connect/widgets/app_drawer.dart';
import 'package:bit_connect/widgets/user_event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/events.dart';

class UserEvents extends StatelessWidget {
  static const routeName = '/user-events';
  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Events'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditEventScreen.routeName);
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: eventsData.events.length,
            itemBuilder: (_, i) => UserEventItem(
                eventsData.events[i].eid, eventsData.events[i].title),
          ),
        ));
  }
}
