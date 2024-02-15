import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_g9/model/user.dart';

class UserRepo {
  static final _db = FirebaseFirestore.instance.collection("User");

  static Future<User?> read(String id) async {
    try {
      final doc = await _db.doc(id).get();
      final data = doc.data();
      if (data == null) return null;
      return User.fromJson(data);
    } on Exception {
      return null;
    }
  }

  static Future<User?> create(String id) async {
    if((await _db.doc(id).get()).exists) return null;
    final data = User(uid: id, events: []);
    try {
      await _db.doc(id).set(data.toJson());
      return data;
    } on Exception {
      return null;
    }
  }

  static Future<void> update(User data) async {
    await _db.doc(data.uid).set(data.toJson());
  }
}
