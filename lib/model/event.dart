class Event {
  String name;
  String date;
  String note;

  Event({
    required this.name,
    required this.date,
    required this.note,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      date: json['date'],
      name: json['name'],
      note: json['note'],
    );
  }
}
