import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ItemModel {
  List<SugarBloodScore> _results = [];

  ItemModel.fromJson(List<QueryDocumentSnapshot<Map<String, dynamic>>> parsedJson) {
    List<SugarBloodScore> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
      SugarBloodScore result = SugarBloodScore(parsedJson[i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<SugarBloodScore> get results => _results;

}


class SugarBloodScore {
  String id;
  int score;
  DateTime checkingTime;
  int unitInsulin;
  String type;
  
  SugarBloodScore(results){
    id = results.id;
    score = results["score"];
    checkingTime = results["checkTime"].toDate();
    unitInsulin = results["unitInsulin"];
    type = results["type"];
    
  }

}


//No need check type anymore
enum CheckType { SEBELUM_MAKAN, SESUDAH_MAKAN, SEBELUM_TIDUR, BANGUN_TIDUR }

extension CheckTypeExtension on CheckType {
  String get type => describeEnum(this);

  String get name {
    switch (this) {
      case CheckType.SEBELUM_MAKAN:
        return "Sebelum Makan";
      case CheckType.SEBELUM_TIDUR:
        return "Sebelum Tidur";
      case CheckType.SESUDAH_MAKAN:
        return "Sesudah Makan";
      case CheckType.BANGUN_TIDUR:
        return "Bangun Tidur";
      default:
        return "Belum memilih tipe";
    }
  }
}
