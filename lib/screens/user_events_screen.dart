import 'package:bit_connect/screens/edit_event_screen.dart';
import 'package:bit_connect/widgets/app_drawer.dart';
import 'package:bit_connect/widgets/user_event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/events.dart';

class UserEvents extends StatelessWidget {
  static const routeName = '/user-events';

  Future<void> _refreshEvents(BuildContext context) async {
    await Provider.of<Events>(context, listen: false).fetchAndSetEvents(true);
  }

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
          future: _refreshEvents(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return _refreshEvents(context);
                      },
                      child: Consumer<Events>(
                        builder: (context, eventsData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: eventsData.events.length,
                            itemBuilder: (_, i) => UserEventItem(
                                eventsData.events[i].eid,
                                eventsData.events[i].title),
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
