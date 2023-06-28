import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

class UserServices {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  // //* Recupera las mediciones de temperatura guardadas en la DB
  // List<MedicionesTemp> retrieveTempdata() {
  //   List<MedicionesTemp> medicionesList = [];
  //   dbRef.child("sensores/temperatura").onChildAdded.listen((data) {
  //     MedicionesTempData medicionesData =
  //         MedicionesTempData.fromJson(data.snapshot.value as Map);
  //     MedicionesTemp medicionesTemp = MedicionesTemp(
  //         key: data.snapshot.key, medicionesTempData: medicionesData);
  //     medicionesList.add(medicionesTemp);
  //   });
  //   return medicionesList;
  // }

  //* Recupera las mediciones de humedad guardadas en la DB
  // List<MedicionesHumedad> retrieveHumedata() {
  //   List<MedicionesHumedad> medicionesList = [];
  //   dbRef.child("sensores/humedad").onChildAdded.listen((data) {
  //     MedicionesHumedadData medicionesData =
  //         MedicionesHumedadData.fromJson(data.snapshot.value as Map);
  //     MedicionesHumedad medicionesTemp = MedicionesHumedad(
  //         key: data.snapshot.key, medicionesHumedadData: medicionesData);
  //     medicionesList.add(medicionesTemp);
  //   });
  //   return medicionesList;
  // }

  //* Recupera las mediciones de cantidad de agua guardadas en la DB
  // List<MedicionesAgua> retrieveAguadata() {
  //   List<MedicionesAgua> medicionesList = [];
  //   dbRef.child("sensores/cant_agua").onChildAdded.listen((data) {
  //     MedicionesAguaData medicionesData =
  //         MedicionesAguaData.fromJson(data.snapshot.value as Map);
  //     MedicionesAgua medicionesTemp = MedicionesAgua(
  //         key: data.snapshot.key, medicionesAguaData: medicionesData);
  //     medicionesList.add(medicionesTemp);
  //   });
  //   return medicionesList;
  // }

  //*Carga de interaccion de los switch
  setSwitch(String nodo, bool estado) async {
    try {
      dbRef.child("sensores/$nodo").set(estado);
      print("datos cargados a: $nodo valor: $estado");
      _setNewOrden(); //* Para actualizar en arduino
      return true;
    } catch (e) {
      print(e);
      print("Error en la carga de datos....");
      return false;
    }
  }

  setData(int umbral) async {
    try {
      dbRef.child("sensores/umbral").set(umbral);
      print("True desde user service");
      _setNewOrden(); //* Para actualizar en arduino
      return true;
    } catch (e) {
      print(e);
      print("false desde user service");
      return false;
    }
  }

  _setNewOrden() async {
    int num = Random().nextInt(10 - 0) + 0;
    print("Numero aleatorio: $num");

    try {
      dbRef.child("sensores/newOrden").set(num);
      print("True desde setNewOrden");
      return true;
    } catch (e) {
      print(e);
      print("false desde setNewOrden");
      return false;
    }
  }
}
