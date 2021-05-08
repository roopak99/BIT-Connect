import 'package:bit_connect/screens/events_overview_screen.dart';
import 'package:flutter/material.dart';

class DummyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy login'),
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.add_moderator),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(EventsOverviewScreen.routeName);
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(EventsOverviewScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
