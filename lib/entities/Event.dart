class Event {
  final int eventId;
  final int ownerId;
  final String title;

  Event({
    required this.eventId,
    required this.ownerId,
    required this.title,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['eventId'],
      ownerId: json['ownerId'],
      title: json['title'],
    );
  }
}