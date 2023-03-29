import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_blood_tracker/src/Repository/blood_api_provider.dart';
import '../Models/sugar_level_model.dart';
import 'package:collection/collection.dart';

class Repository {
  final _bloodApiProvider = BloodApiProvider();

  Future<Map<DateTime, List<SugarBloodScore>>> fetchAllScores() async {
    ItemModel temp = await _bloodApiProvider.fetchScoreList();
    var groups = groupBy(
        temp.results,
        (obj) => DateTime(obj.checkingTime.year, obj.checkingTime.month,
            obj.checkingTime.day));
    return groups;
  }

  //Should implement error handling if failed adding new record
  Future<String> addNewTrack(data) async {
    DocumentReference<Object> newItem =
        await _bloodApiProvider.postNewTrack(data);
    if (newItem.id == null) {
      return "Gagal menambahkan item!";
    }
    return "Berhasil menambahkan item!";
  }
}
