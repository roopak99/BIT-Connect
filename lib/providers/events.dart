import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/event.dart';

class Events with ChangeNotifier {
  List<Event> _events = [
    Event(
      eid: 'e1',
      title: 'event 1',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 15),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e2',
      title: 'event 2',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 16),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e3',
      title: 'event 3',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 17),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e4',
      title: 'event 4',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 18),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e5',
      title: 'event 5',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 19),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e1',
      title: 'event 1',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 15),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e2',
      title: 'event 2',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 16),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e3',
      title: 'event 3',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 17),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e4',
      title: 'event 4',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 18),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e5',
      title: 'event 5',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 19),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e1',
      title: 'event 1',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 15),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e2',
      title: 'event 2',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 16),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e3',
      title: 'event 3',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 17),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e4',
      title: 'event 4',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 18),
      branch: 'cse',
      batch: '2018-22',
    ),
    Event(
      eid: 'e5',
      title: 'event 5',
      description: 'this is product description',
      eventDate: DateTime.utc(2021, 5, 19),
      branch: 'cse',
      batch: '2018-22',
    ),
  ];

  Future<void> addEvent(Event event) async {
    var url = Uri.parse(
        'https://bit-connect-ecc06-default-rtdb.asia-southeast1.firebasedatabase.app/events.json');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'title': event.title,
          'description': event.description,
          'date': event.eventDate.toString(),
          'branch': event.branch,
          'batch': event.batch,
        }),
      );
      final newEvent = Event(
        title: event.title,
        batch: event.batch,
        branch: event.branch,
        description: event.description,
        eventDate: event.eventDate,
        eid: jsonDecode(response.body)['name'],
      );
      _events.insert(0, newEvent);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateEvent(String eid, Event newEvent) {
    final eventIndex = _events.indexWhere((event) => event.eid == eid);
    if (eventIndex >= 0) {
      _events[eventIndex] = newEvent;
      notifyListeners();
    } else {
      print('cannot update');
    }
  }

  void deleteEvent(String eid) {
    _events.removeWhere((event) => event.eid == eid);
    notifyListeners();
  }

  List<Event> get events {
    return [..._events];
  }

  Event findById(String id) {
    return _events.firstWhere((event) => event.eid == id);
  }
}
