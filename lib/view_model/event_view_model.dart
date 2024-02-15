import "package:flutter/material.dart";
import 'package:todo_list_g9/model/user.dart';
import 'package:todo_list_g9/model/event.dart';
import 'package:todo_list_g9/repo/user_repo.dart';
import 'package:todo_list_g9/view_model/user_view_model.dart';

class EventViewModel with ChangeNotifier {
  String? _uid;
  User? _user;

  EventViewModel(UserViewModel vm) {
    _uid = vm.user?.uid;
    if (_uid != null) {
      UserRepo.read(_uid!).then((value) {
        _user = value;
        notifyListeners();
      });
    }
  }

  List<dynamic>? get items => _user?.events;

  void removeEvent(int index) {
    items!.removeAt(index);
    UserRepo.update(_user!);
    notifyListeners();
  }

  void addEvent(String name, String date, String note) {
    if (_user == null) {
      return;
    }
    var newEvent = Event(
      name: name,
      date: date,
      note: note,
    );
    _user!.events.add(newEvent);
    UserRepo.update(_user!);
    notifyListeners();
  }
}
