import 'package:bit_connect/screens/user_events_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello User'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_today_rounded),
            title: Text("Your Events"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserEvents.routeName);
            },
          )
        ],
      ),
    );
  }
}
