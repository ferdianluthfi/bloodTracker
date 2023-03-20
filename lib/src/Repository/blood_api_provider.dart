import 'package:new_blood_tracker/src/Models/sugar_level_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BloodApiProvider {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listData;
  CollectionReference ref = FirebaseFirestore.instance
      .collection('histories/zH9z9CLJDX7C2GZRKeZ9/sugar_blood_level');

  Future<ItemModel> fetchScoreList() async {
    QuerySnapshot eventsQuery = await ref.orderBy('checkTime', descending: true).get();
    return ItemModel.fromJson(eventsQuery.docs);
  }

  Future<DocumentReference<Object>> postNewTrack(data) async {
    DocumentReference<Object> newTrack;
    await ref
        .add(data).then((value) => newTrack = value);

    return newTrack;
        
  }
}
