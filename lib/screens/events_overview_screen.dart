import 'package:bit_connect/widgets/app_drawer.dart';
import 'package:bit_connect/widgets/events_list.dart';
import 'package:flutter/material.dart';

class EventsOverviewScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events Overview Screen'),
      ),
      body: EventsList(),
    );
  }
}
