import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_blood_tracker/src/Services/auth_provider.dart';

import '../Models/sugar_level_model.dart';

class FirestoreMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  void addNewTrack(Map<String, dynamic> data) {
    _db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("sugar_histories")
        .add(data);
  }

  //TODO:delete

  //TODO:update

}

final databaseProvider = Provider<FirestoreMethods>((ref) {
  return FirestoreMethods();
});

final recordsListProvider = StreamProvider((ref) {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final currentUser = ref.watch(authStateProvider).value;

  if (currentUser == null) {
    return const Stream.empty();
  }

  var dbRef = db
      .collection("users")
      .doc(currentUser.uid)
      .collection("sugar_histories")
      .orderBy('checkTime', descending: true);

  return dbRef.snapshots().map((list) => groupBy(
      list.docs
          .map((doc) => SugarBloodScore.fromMap(doc.id, doc.data()))
          .toList(),
      (SugarBloodScore obj) => DateTime(obj.checkingTime.year,
          obj.checkingTime.month, obj.checkingTime.day)));
});
