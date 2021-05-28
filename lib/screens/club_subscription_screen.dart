import 'package:flutter/material.dart';

class ClubSubscriptionScreen extends StatelessWidget {
  static const routeName = '/club-sub-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Subscriptions'),
        centerTitle: true,
      ),
    );
  }
}
