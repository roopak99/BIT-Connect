import 'package:bit_connect/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';

class EventDetail extends StatelessWidget {
  static const routeName = '/event-detail';

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context).settings.arguments as String;
    final loadedEvent =
        Provider.of<Events>(context, listen: false).findById(eventId);

    String timeleft =
        loadedEvent.eventDate.difference(DateTime.now()).toString();

    String timeleftmins = timeleft.substring(3, 5);
    String timelefthrs = timeleft.substring(0, 2);

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
                padding: const EdgeInsets.only(
                  left: 7,
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
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(loadedEvent.branch),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: VerticalDivider(),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today_rounded),
                              Text('Date'),
                              Text(DateFormat('dd MMM yyyy')
                                  .format(loadedEvent.eventDate)),
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
                                      .isBefore(DateTime.now())
                                  ? 'Event Expired'
                                  : '$timelefthrs Hours $timeleftmins Mins'),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_rounded),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Description',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableLinkify(
                        enableInteractiveSelection: true,
                        scrollPhysics: BouncingScrollPhysics(),
                        style: TextStyle(fontSize: 16),
                        onOpen: _onOpen,
                        text: loadedEvent.description,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
