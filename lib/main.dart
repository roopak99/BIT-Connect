import 'package:bit_connect/providers/events.dart';
import 'package:bit_connect/screens/edit_event_screen.dart';
import 'package:bit_connect/screens/event_detail.dart';
import 'package:bit_connect/screens/events_overview_screen.dart';
import 'package:bit_connect/screens/user_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Events(),
      child: MaterialApp(
        title: 'BIT Connect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: DummyLogin(),
        routes: {
          '/': (context) => EventsOverviewScreen(),
          EventDetail.routeName: (context) => EventDetail(),
          UserEvents.routeName: (context) => UserEvents(),
          EditEventSceen.routeName: (context) => EditEventSceen(),
        },
      ),
    );
  }
}
