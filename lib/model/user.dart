import 'package:todo_list_g9/model/event.dart';

class User {
  String uid;
  List<dynamic> events;

  User({
    required this.uid,
    required this.events,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var temp = json['event'];
    return User(
      uid: json['uid'],
      events: temp.map((eve) => Event.fromJson(eve)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "event": events.map((eve) => transformEvent(eve)),
    };
  }

  Map<String, dynamic> transformEvent(Event eve) {
    return {
      'name': eve.name,
      'date': eve.date,
      'note': eve.note,
    };
  }
}
