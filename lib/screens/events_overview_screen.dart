import 'package:bit_connect/widgets/app_drawer.dart';
import 'package:bit_connect/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events.dart';

class EventsOverviewScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _EventsOverviewScreenState createState() => _EventsOverviewScreenState();
}

class _EventsOverviewScreenState extends State<EventsOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Events>(context).fetchAndSetEvents().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events Overview Screen'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : EventsList(),
    );
  }
}
