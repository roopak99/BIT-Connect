import 'package:bit_connect/providers/auth.dart';
import 'package:bit_connect/screens/user_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Logout"),
          content: new Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
              icon: Icon(Icons.logout),
              label: Text('Yes'),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.cancel_rounded),
              label: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                  Navigator.of(context)
                      .pushReplacementNamed(UserEvents.routeName);
                },
              ),
              Divider(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text("Logout"),
              onTap: () {
                _showDialog(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
