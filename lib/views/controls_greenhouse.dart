import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:greenhouse_project/services/user_services.dart';
import 'package:greenhouse_project/widgets/widgets.dart';

class ControlsGreenhouse extends StatefulWidget {
  const ControlsGreenhouse({Key? key}) : super(key: key);

  @override
  State<ControlsGreenhouse> createState() => _ControlsGreenhouseState();
}

class _ControlsGreenhouseState extends State<ControlsGreenhouse> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  int _sliderValue = 25;
  bool _sliderEnable = true;
  int _duelCommandment = 25;
  String tempUmbral = "";

  @override
  void initState() {
    super.initState();
    retrieveUmbralData();
  }

  //*Carga el valor de umbral desde la DB
  retrieveUmbralData() {
    dbRef.child("sensores/umbral").onValue.listen((event) {
      setState(() {
        if (event.snapshot.value.toString().isNotEmpty) {
          //print("Umbral: ${event.snapshot.value}");
          tempUmbral = event.snapshot.value.toString();
          _sliderValue = int.parse(tempUmbral);
          //print("_sliderValue: ${_sliderValue}");
          setState(() {});
        } else {
          print("Sin data...");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          //Titulo de la view
          const PageTitle(
            tittle: 'Sistema de control',
            subTitle:
                'En esta sección encontrara los controles de cada servicio',
            textColor: Colors.black,
          ),

          if (tempUmbral.isNotEmpty)
            Text(
              "Umbral: $_sliderValue° C.",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),

          if (tempUmbral.isNotEmpty)
            Column(children: [
              Slider.adaptive(
                  min: 20,
                  max: 40,
                  activeColor: const Color.fromARGB(224, 48, 45, 45),
                  value: _sliderValue.toDouble(),
                  onChanged: _sliderEnable
                      ? (value) async {
                          print(value);
                          _sliderValue = value.round();
                          UserServices().setData(_sliderValue);
                          setState(() {});
                        }
                      : null),
            ]),

          if (tempUmbral.isNotEmpty) const CardControlTable(),

          if (tempUmbral.isEmpty)
            Column(children: const [
              SizedBox(height: 250),
              CircularProgressIndicator(strokeWidth: 5)
            ])
        ],
      ),
    );
  }
}
