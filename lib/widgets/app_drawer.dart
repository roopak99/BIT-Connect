import 'dart:convert';

import 'package:bit_connect/providers/auth.dart';
import 'package:bit_connect/screens/settings.dart';
import 'package:bit_connect/screens/user_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

  bool _isFirst = true;

  @override
  void initState() {
    if (_isFirst) {
      _getuserName();
      setState(() {
        _isFirst = false;
      });
    }

    super.initState();
  }

  String username = 'user';
  Future<void> _getuserName() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return '';
    }
    final extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;
    setState(() {
      username = extractedUserData['username'];
    });
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
                title: Text('Welcome $username'),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                leading: Icon(Icons.home_rounded),
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today_rounded),
                title: Text(
                  "Your Events",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).popAndPushNamed(UserEvents.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).popAndPushNamed(Settings.routeName);
                },
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: ListTile(
                  leading: Icon(Icons.exit_to_app_rounded),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    _showDialog(context);
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'v1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
