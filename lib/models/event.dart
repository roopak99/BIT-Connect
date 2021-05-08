import 'package:flutter/foundation.dart';

class Event {
  final String eid;
  final String title;
  final String description;
  final String imageURL;
  final DateTime eventDate;

  Event({
    @required this.eid,
    @required this.title,
    @required this.description,
    @required this.eventDate,
    this.imageURL,
  });
}
