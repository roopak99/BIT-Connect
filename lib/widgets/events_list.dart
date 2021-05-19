import 'package:bit_connect/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './event_tile.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventData = Provider.of<Events>(context);
    final loadedEvents = eventData.events;
    return ListView.builder(
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index) => EventTile(
        eid: loadedEvents[index].eid,
        title: loadedEvents[index].title,
        eventDate: loadedEvents[index].eventDate,
        batch: loadedEvents[index].batch,
        branch: loadedEvents[index].branch,
      ),
      itemCount: loadedEvents.length,
    );
  }
}
