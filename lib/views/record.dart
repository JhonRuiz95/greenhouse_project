import 'dart:io';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:greenhouse_project/models/models.dart';
import 'package:greenhouse_project/services/user_services.dart';
import 'package:greenhouse_project/theme/app_theme.dart';
import 'package:greenhouse_project/widgets/widgets.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  int count = 0;
  bool _sliderEnable = true;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  List<MedicionesTemp> medicionesTempList = [];
  List<MedicionesHumedad> medicionesHumList = [];
  List<MedicionesAgua> medicionesAguaList = [];
  UserServices userServices = UserServices();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    //medicionesList = userServices.retrieveTempdata();
    retrieveTempdata();
    retrieveHumdata();
    retrieveAguadata();
  }

  void displayDialog(BuildContext context, String titulo) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(titulo.isNotEmpty ? titulo : "Na"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (titulo == "Temperatura")
                  for (int i = medicionesTempList.length - 1; i > 0; i--)
                    medicionesWidget(medicionesTempList[i], titulo)
                else if (titulo == "Humedad")
                  for (int i = medicionesHumList.length - 1; i > 0; i--)
                    medicionesHumWidget(medicionesHumList[i], titulo)
                else
                  for (int i = medicionesAguaList.length - 1; i > 0; i--)
                    medicionesAguaWidget(medicionesAguaList[i], titulo)
              ],
            ),
            actions: [
              // TextButton(
              //     onPressed: () => Navigator.pop(context),
              //     child: const Text('Cancelar',
              //         style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(
              tittle: 'Historial',
              subTitle:
                  'En esta sección encontrara el historial de los datos capturados por los sensores y en que hora del dia fue su captura.',
              textColor: Colors.black,
            ),
            const SizedBox(height: 140),
            // GestureDetector(
            //   child: AnimatedContainer(
            //     width: loading ? 180 : 30, //*Corregir
            //     height: loading ? 55 : 30,
            //     duration: const Duration(milliseconds: 400),
            //     decoration: BoxDecoration(
            //         color: const Color.fromARGB(113, 17, 18, 30),
            //         borderRadius: BorderRadius.circular(50)),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         !loading
            //             ? Center(
            //                 child: Container(
            //                   width: 20,
            //                   height: 20,
            //                   child: const CircularProgressIndicator(
            //                     color: Colors.white,
            //                     strokeWidth: 2.0,
            //                   ),
            //                 ),
            //               )
            //             : const Center(
            //                 child: Text(
            //                   "Temperatura",
            //                   style: TextStyle(
            //                       color: Colors.white, fontSize: 20),
            //                 ),
            //               )
            //       ],
            //     ),
            //   ),
            //   onTap: () {
            //     loading ? loading = false : loading = true;
            //     setState(() {});
            //     print("gesture detector $loading");
            //   },
            // ),

            if (medicionesTempList.isEmpty ||
                medicionesHumList.isEmpty ||
                medicionesAguaList.isEmpty)
              Column(children: const [
                SizedBox(height: 250),
                CircularProgressIndicator(strokeWidth: 5)
              ])
            else
              _Botones(context)
          ],
        ),
      ),
    );
  }

  Column _Botones(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text('Temperatura', style: TextStyle(fontSize: 18)),
          ),
          onPressed: () => Platform.isAndroid
              ? displayDialog(context, "Temperatura")
              : print("IOS"), //displayDialogIOS(context),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
            child: Text('Humedad', style: TextStyle(fontSize: 18)),
          ),
          //onPressed: () => displayDialogAndroid(context),
          onPressed: () => Platform.isAndroid
              ? displayDialog(context, "Humedad")
              : print("IOS"), //displayDialogIOS(context),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Text('Agua', style: TextStyle(fontSize: 18)),
          ),
          //onPressed: () => displayDialogAndroid(context),
          onPressed: () => Platform.isAndroid
              ? displayDialog(context, "Agua")
              : print("IOS"), //displayDialogIOS(context),
        ),
      ],
    );
  }

  void retrieveTempdata() {
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

  void retrieveHumdata() {
    //List<MedicionesTemp> medicionesList = [];
    dbRef.child("sensores/humedad").onChildAdded.listen((data) {
      MedicionesHumedadData medicionesData =
          MedicionesHumedadData.fromJson(data.snapshot.value as Map);
      MedicionesHumedad medicionesHum = MedicionesHumedad(
          key: data.snapshot.key, medicionesHumedadData: medicionesData);
      medicionesHumList.add(medicionesHum);
      setState(() {});
    });
    //return medicionesList;
  }

  void retrieveAguadata() {
    //List<MedicionesTemp> medicionesList = [];
    dbRef.child("sensores/cant_agua").onChildAdded.listen((data) {
      MedicionesAguaData medicionesData =
          MedicionesAguaData.fromJson(data.snapshot.value as Map);
      MedicionesAgua medicionesAgua = MedicionesAgua(
          key: data.snapshot.key, medicionesAguaData: medicionesData);
      medicionesAguaList.add(medicionesAgua);
      setState(() {});
    });
    //return medicionesList;
  }

  Widget medicionesWidget(MedicionesTemp medicionesList, String tittle) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$tittle: ${medicionesList.medicionesTempData!.temp}",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Fecha/Hora(T): ${medicionesList.medicionesTempData!.hora}",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget medicionesHumWidget(MedicionesHumedad medicionesList, String tittle) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$tittle: ${medicionesList.medicionesHumedadData!.humedad}",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Fecha/Hora(T): ${medicionesList.medicionesHumedadData!.hora}",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget medicionesAguaWidget(MedicionesAgua medicionesList, String tittle) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$tittle: ${medicionesList.medicionesAguaData!.agua}",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Fecha/Hora(T): ${medicionesList.medicionesAguaData!.hora}",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
      child: const CircularProgressIndicator(
        color: AppTheme.primary,
      ),
    );
  }
}
