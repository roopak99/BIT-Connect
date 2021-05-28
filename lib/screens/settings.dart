import 'package:bit_connect/screens/club_subscription_screen.dart';
import 'package:bit_connect/screens/user_detail_screen.dart';
import 'package:bit_connect/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Your Details'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(UserDetailScreen.routeName);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.people_alt_rounded),
                    title: Text('Club Subscriptions'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ClubSubscriptionScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.info_sharp),
                    title: Text('About The App'),
                    onTap: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
