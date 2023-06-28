import 'dart:convert';

class MedicionesTemp {
  String? key;
  MedicionesTempData? medicionesTempData;

  MedicionesTemp({this.key, this.medicionesTempData});
}

class MedicionesTempData {
  final String temp;
  final String hora;

  MedicionesTempData({
    required this.temp,
    required this.hora,
  });

  factory MedicionesTempData.fromRawJson(String str) =>
      MedicionesTempData.fromJson(json.decode(str));

  factory MedicionesTempData.fromJson(Map<dynamic, dynamic> json) =>
      MedicionesTempData(hora: json["hora"], temp: json["temp"].toString());
}
