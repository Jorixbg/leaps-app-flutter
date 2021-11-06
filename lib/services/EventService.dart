import 'dart:convert';

import '../entities/Event.dart';

class EventService {

  static List<Event> parseEvents(response) {
    Iterable l = json.decode(response);
    List<Event> events = [];
    for (final d in l) {
      Event event = Event.fromJson(d);
      events.add(event);
    }
    return events;
  }

}