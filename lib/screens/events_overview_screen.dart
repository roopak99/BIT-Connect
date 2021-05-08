import 'package:bit_connect/widgets/event_tile.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';

class EventsOverviewScreen extends StatelessWidget {
  final List<Event> loadedEvents = [
    Event(
        eid: 'e1',
        title: 'event 1',
        description: 'this is product description',
        eventDate: DateTime.utc(2021, 5, 15)),
    Event(
        eid: 'e2',
        title: 'event 2',
        description: 'this is product description',
        eventDate: DateTime.utc(2021, 5, 16)),
    Event(
        eid: 'e3',
        title: 'event 3',
        description: 'this is product description',
        eventDate: DateTime.utc(2021, 5, 17)),
    Event(
        eid: 'e4',
        title: 'event 4',
        description: 'this is product description',
        eventDate: DateTime.utc(2021, 5, 18)),
    Event(
        eid: 'e5',
        title: 'event 5',
        description: 'this is product description',
        eventDate: DateTime.utc(2021, 5, 19)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events Overview Screen'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => EventTile(
          eid: loadedEvents[index].eid,
          title: loadedEvents[index].title,
          eventDate: loadedEvents[index].eventDate,
        ),
        itemCount: loadedEvents.length,
      ),
    );
  }
}
