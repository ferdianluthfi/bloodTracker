import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_blood_tracker/src/Models/sugar_level_model.dart';

class FirestoreMethods {
  final FirebaseFirestore _db;
  FirestoreMethods(this._db);

  Stream<Map<DateTime, List<SugarBloodScore>>?> streamListRecords() {
    
    String? userId;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // userId = "1fQ2dDwpymPST4cKSU6AkNKR3Vu2";
      } else {
        userId = user.uid;
      }
    });

    if (userId == null) {
      const Stream.empty();
    }
    print(userId);
    var ref = _db
        .collection("users")
        .doc(userId)
        .collection("sugar_histories")
        .orderBy('checkTime', descending: true);

        return ref.snapshots().map((list) => groupBy(
        list.docs
            .map((doc) => SugarBloodScore.fromMap(doc.id, doc.data()))
            .toList(),
        (obj) => DateTime(obj.checkingTime.year, obj.checkingTime.month,
            obj.checkingTime.day)));  
  }

  void addNewTrack(Map<String, dynamic> data) {
    _db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("sugar_histories")
        .add(data);
  }
}
