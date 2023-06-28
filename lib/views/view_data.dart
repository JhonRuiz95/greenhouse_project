import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:greenhouse_project/models/models.dart';
import 'package:greenhouse_project/widgets/widgets.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  List<MedicionesTemp> medicionesTempList = [];
  List<MedicionesHumedad> medicionesHumeList = [];
  List<MedicionesAgua> medicionesAguaList = [];
  bool stateVentilator = false;
  String stateVentilatorData = "";

  String stateGasData = "";

  String stateLumensData = "";

  bool stateAlimentos = false;
  String stateAlimentosData = "";

  bool stateAlimentosB = false;
  String stateAlimentosDataB = "";

  @override
  void initState() {
    super.initState();
    retrieveTempData();
    retrieveHumeData();
    retrieveAguaData();
    retrieveVentilationData();
    retrieveAlimentosData();
    retrieveAlimentosbData();
    retrieveAmoniacoData();
    retrieveLuxData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          //Titulo de la vista view
          const PageTitle(
            tittle: 'Bienvenido.',
            subTitle:
                'En esta sección podras vizualizar en tiempo real los datos de tu criadero.',
            textColor: Colors.black,
          ),

          //Card table
          if (medicionesTempList.isNotEmpty &&
              medicionesHumeList.isNotEmpty &&
              medicionesAguaList.isNotEmpty)
            CardTable(
              medicionesTempList:
                  medicionesTempList[medicionesTempList.length - 1],
              medicionesHumedadList:
                  medicionesHumeList[medicionesHumeList.length - 1],
              medicionesAguaList:
                  medicionesAguaList[medicionesAguaList.length - 1],
              stateVentilador: stateVentilatorData,
              stateAlimentos: stateAlimentosData,
              stateAlimentosB: stateAlimentosDataB,
              amoniaco: stateGasData,
              lumens: stateLumensData,
            ),

          if (medicionesTempList.isEmpty ||
              medicionesHumeList.isEmpty ||
              medicionesAguaList.isEmpty)
            Column(children: const [
              SizedBox(height: 250),
              CircularProgressIndicator(strokeWidth: 5)
            ])
        ],
      ),
    );
  }

  void retrieveTempData() {
    //List<MedicionesTemp> medicionesList = [];
    dbRef.child("sensores/temperatura").onChildAdded.listen((data) {
      MedicionesTempData medicionesData =
          MedicionesTempData.fromJson(data.snapshot.value as Map);
      MedicionesTemp medicionesTemp = MedicionesTemp(
          key: data.snapshot.key, medicionesTempData: medicionesData);
      medicionesTempList.add(medicionesTemp);
      setState(() {});
    });
    //return medicionesList;
  }

  void retrieveHumeData() {
    //List<MedicionesTemp> medicionesList = [];
    dbRef.child("sensores/humedad").onChildAdded.listen((data) {
      MedicionesHumedadData medicionesData =
          MedicionesHumedadData.fromJson(data.snapshot.value as Map);
      MedicionesHumedad medicionesHumedad = MedicionesHumedad(
          key: data.snapshot.key, medicionesHumedadData: medicionesData);
      medicionesHumeList.add(medicionesHumedad);
      setState(() {});
    });
    //return medicionesList;
  }

  void retrieveAguaData() {
    //List<MedicionesTemp> medicionesList = [];
    dbRef.child("sensores/cant_agua").onChildAdded.listen((data) {
      MedicionesAguaData medicionesData =
          MedicionesAguaData.fromJson(data.snapshot.value as Map);
      MedicionesAgua medicionesAgua = MedicionesAgua(
          key: data.snapshot.key, medicionesAguaData: medicionesData);
      medicionesAguaList.add(medicionesAgua);
      setState(() {
        // print(
        //     "Agua: ${medicionesAguaList[medicionesAguaList.length - 1].medicionesAguaData!.agua}");
      });
    });
    //return medicionesList;
  }

  void retrieveVentilationData() {
    dbRef.child("sensores/ventilador_state").onValue.listen((event) {
      print("gas: ${event.snapshot.value}");
      setState(() {
        if (event.snapshot.value.toString() == "true") {
          stateVentilator = true;
          stateVentilatorData = "On";
        } else {
          stateVentilator = false;
          stateVentilatorData = "Off";
        }
      });
    });
    //print("Estado del ventilador: ${estadoVentilador.value}");
    //if (estadoVentilador.value != stateVentilator) {

    //}
    //print("Estado ventilador final: ${stateVentilator}");
    setState(() {});
  }

  void retrieveAmoniacoData() async {
    dbRef.child("sensores/stateGas").onValue.listen((event) {
      setState(() {
        print("gas: ${event.snapshot.value}");
        if (event.snapshot.value.toString() == "true") {
          stateGasData = "Si";
        } else {
          stateGasData = "No";
        }
      });
    });
  }

  void retrieveLuxData() {
    DatabaseReference luxRef =
        FirebaseDatabase.instance.ref().child("sensores/lumens");
    luxRef.onValue.listen((event) {
      // Event es una clase de Firebase que contiene los datos actualizados
      // Se puede acceder al valor actualizado con event.snapshot.value
      print("Valor actual de Lux: ${event.snapshot.value}");
      setState(() {
        // Actualiza el estado de la aplicación con el valor actualizado
        stateLumensData = event.snapshot.value.toString();
      });
    });
  }

  void retrieveAlimentosData() async {
    dbRef.child("sensores/alimentos1_state").onValue.listen((event) {
      setState(() {
        print("Estado alimentos1: ${event.snapshot.value}");

        if (event.snapshot.value.toString() == "true") {
          stateAlimentos = true;
          stateAlimentosData = "On";
        } else {
          stateAlimentos = false;
          stateAlimentosData = "Off";
        }
      });
    });
  }

  void retrieveAlimentosbData() async {
    dbRef.child("sensores/alimentos2_state").onValue.listen((event) {
      setState(() {
        if (event.snapshot.value.toString() == "true") {
          stateAlimentosB = true;
          stateAlimentosDataB = "On";
        } else {
          stateAlimentosB = false;
          stateAlimentosDataB = "Off";
        }
      });
    });
    setState(() {});
  }
}
