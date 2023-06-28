import 'dart:convert';

class MedicionesHumedad {
  String? key;
  MedicionesHumedadData? medicionesHumedadData;

  MedicionesHumedad({this.key, this.medicionesHumedadData});
}

class MedicionesHumedadData {
  final String humedad;
  final String hora;

  MedicionesHumedadData({
    required this.humedad,
    required this.hora,
  });

  factory MedicionesHumedadData.fromRawJson(String str) =>
      MedicionesHumedadData.fromJson(json.decode(str));

  factory MedicionesHumedadData.fromJson(Map<dynamic, dynamic> json) =>
      MedicionesHumedadData(
          hora: json["hora"], humedad: json["humedad"].toString());
}
