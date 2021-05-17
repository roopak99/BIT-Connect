import 'package:bit_connect/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/event.dart';

class Events with ChangeNotifier {
  List<Event> _events = [];
  String authToken;
  String userId;
  Events(this.authToken, this.userId, this._events);

  List<Event> get events {
    return [..._events];
  }

  Event findById(String id) {
    return _events.firstWhere((event) => event.eid == id);
  }

  Future<void> fetchAndSetEvents([bool filterByUser = false]) async {
    var filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url = Uri.parse(
        'https://bit-connect-ecc06-default-rtdb.asia-southeast1.firebasedatabase.app/events.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Event> loadedEvents = [];

      extractedData.forEach((eventId, eventData) {
        loadedEvents.insert(
            0,
            Event(
                eid: eventId,
                title: eventData['title'],
                description: eventData['description'],
                batch: eventData['batch'],
                branch: eventData['branch'],
                eventDate: DateTime.parse(eventData['date'])));
      });
      _events = loadedEvents;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addEvent(Event event) async {
    var url = Uri.parse(
        'https://bit-connect-ecc06-default-rtdb.asia-southeast1.firebasedatabase.app/events.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'title': event.title,
          'description': event.description,
          'date': event.eventDate.toString(),
          'branch': event.branch,
          'batch': event.batch,
          'creatorId': userId,
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
      throw error;
    }
  }

  Future<void> updateEvent(String eid, Event newEvent) async {
    final eventIndex = _events.indexWhere((event) => event.eid == eid);

    if (eventIndex >= 0) {
      var url = Uri.parse(
          'https://bit-connect-ecc06-default-rtdb.asia-southeast1.firebasedatabase.app/events/$eid.json?auth=$authToken');
      await http.patch(url,
          body: jsonEncode({
            'title': newEvent.title,
            'description': newEvent.description,
            'date': newEvent.eventDate.toString(),
            'batch': newEvent.batch,
            'branch': newEvent.branch,
          }));

      _events[eventIndex] = newEvent;
      notifyListeners();
    } else {}
  }

  Future<void> deleteEvent(String eid) async {
    var url = Uri.parse(
        'https://bit-connect-ecc06-default-rtdb.asia-southeast1.firebasedatabase.app/events/$eid.json?auth=$authToken');
    final existingEventIndex = _events.indexWhere((event) => event.eid == eid);
    var existingEvent = _events[existingEventIndex];
    _events.removeAt(existingEventIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _events.insert(existingEventIndex, existingEvent);
      notifyListeners();
      throw HttpException('Could not delete');
    }

    existingEvent = null;
  }
}
