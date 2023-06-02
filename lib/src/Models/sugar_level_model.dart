import 'package:flutter/foundation.dart';

class SugarBloodScore {
  String id;
  int score;
  DateTime checkingTime;
  int unitInsulin;
  String type;

  SugarBloodScore(
      {required this.id,required this.score,required this.checkingTime, required this.type, required this.unitInsulin});

  factory SugarBloodScore.fromMap(String id, Map data) {
    return SugarBloodScore(
      id: id,
      score: data["score"],
      checkingTime: data["checkTime"].toDate(),
      unitInsulin: data["unitInsulin"],
      type: data["type"],
    );
  }
}

//No need check type anymore
// ignore: constant_identifier_names
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
