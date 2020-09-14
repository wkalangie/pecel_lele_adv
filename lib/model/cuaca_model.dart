// To parse this JSON data, do
//
//     final cuacaModel = cuacaModelFromJson(jsonString);

import 'dart:convert';

List<CuacaModel> cuacaModelFromJson(String str) => List<CuacaModel>.from(json.decode(str).map((x) => CuacaModel.fromJson(x)));

String cuacaModelToJson(List<CuacaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CuacaModel {
  CuacaModel({
    this.kota,
    this.pagi,
    this.siang,
    this.malam,
    this.diniHari,
    this.suhu,
    this.kelembaban,
  });

  String kota;
  String pagi;
  String siang;
  String malam;
  String diniHari;
  String suhu;
  String kelembaban;

  factory CuacaModel.fromJson(Map<String, dynamic> json) => CuacaModel(
    kota: json["Kota"],
    pagi: json["Pagi"],
    siang:json["Siang"],
    malam: json["Malam"],
    diniHari: json["Dini Hari"],
    suhu: json["Suhu"],
    kelembaban: json["Kelembaban"],
  );

  Map<String, dynamic> toJson() => {
    "Kota": kota,
    "Pagi": pagi,
    "Siang": siang,
    "Malam": malam,
    "Dini Hari": diniHari,
    "Suhu": suhu,
    "Kelembaban": kelembaban,
  };
}

enum DiniHari { BERAWAN, CERAH, CERAH_BERAWAN, KABUT }

final diniHariValues = EnumValues({
  "Berawan": DiniHari.BERAWAN,
  "Cerah": DiniHari.CERAH,
  "Cerah Berawan": DiniHari.CERAH_BERAWAN,
  "Kabut": DiniHari.KABUT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
