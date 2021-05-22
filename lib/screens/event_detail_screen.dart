import 'package:bit_connect/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

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
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Icon(Icons.info_rounded),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      loadedEvent.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_view_day_rounded),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(loadedEvent.batch),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.people_rounded),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(loadedEvent.branch),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: VerticalDivider(),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today_rounded),
                              Text('Event Date'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.alarm),
                              Text("Time left"),
                              Text(loadedEvent.eventDate
                                  .difference(DateTime.now())
                                  .toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            SelectableLinkify(
              onOpen: (link) => print("Clicked ${link.url}!"),
              text: loadedEvent.description,
            ),
          ],
        ),
      ),
    );
  }
}
