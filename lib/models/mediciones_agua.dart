import 'dart:convert';

class MedicionesAgua {
  String? key;
  MedicionesAguaData? medicionesAguaData;

  MedicionesAgua({this.key, this.medicionesAguaData});
}

class MedicionesAguaData {
  final String agua;
  final String hora;

  MedicionesAguaData({
    required this.agua,
    required this.hora,
  });

  factory MedicionesAguaData.fromRawJson(String str) =>
      MedicionesAguaData.fromJson(json.decode(str));

  factory MedicionesAguaData.fromJson(Map<dynamic, dynamic> json) =>
      MedicionesAguaData(hora: json["hora"], agua: json["agua"].toString());
}
