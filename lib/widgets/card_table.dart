import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:greenhouse_project/models/models.dart';
import 'package:greenhouse_project/theme/app_theme.dart';

class CardTable extends StatelessWidget {
  MedicionesTemp medicionesTempList;
  MedicionesHumedad medicionesHumedadList;
  MedicionesAgua medicionesAguaList;
  String stateVentilador;
  String stateAlimentos;
  String stateAlimentosB;
  String amoniaco;
  String lumens;
  CardTable(
      {Key? key,
      required this.medicionesTempList,
      required this.medicionesHumedadList,
      required this.medicionesAguaList,
      this.stateVentilador = "N/a",
      this.stateAlimentos = "N/a",
      this.stateAlimentosB = "N/a",
      this.amoniaco = "N/a",
      this.lumens = "N/a"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int porcAgua = int.parse(medicionesAguaList.medicionesAguaData!.agua);

    porcAgua = ((porcAgua * 100) / 4000).round();

    double lumensTemp = double.parse(lumens);
    lumens = lumensTemp.toStringAsFixed(1);

    //print("Card table linea 28: $stateVentilador");
    return Table(
      children: [
        TableRow(children: [
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.thermostat_auto_outlined,
            title: 'Temperatura',
            valor: medicionesTempList.medicionesTempData!.temp.isNotEmpty
                ? medicionesTempList.medicionesTempData!.temp
                : "N/a",
            signo: '°',
          ),
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.thermostat_auto_outlined,
            title: 'Humedad',
            valor: medicionesHumedadList.medicionesHumedadData!.humedad,
            signo: '%',
          ),
        ]),
        TableRow(children: [
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.food_bank_outlined,
            title: 'Dispensador de alimentos 1',
            valor: stateAlimentos,
            signo: '',
          ),
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.food_bank_outlined,
            title: 'Dispensador de alimentos 2',
            valor: stateAlimentosB,
            signo: '',
          ),
        ]),
        TableRow(children: [
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.water,
            title: 'Agua',
            valor: porcAgua.toString().isNotEmpty ? porcAgua.toString() : "N/a",
            signo: '%',
          ),
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.air_sharp,
            title: 'Amoniaco',
            valor: amoniaco,
            signo: '',
          ),
        ]),
        TableRow(children: [
          _SingleCard(
            color: AppTheme.primary,
            icon: Icons.light_mode,
            title: 'Luz ambiente',
            valor: lumens,
            signo: 'Lx',
          ),
          _SingleCard(
            color: AppTheme.primary,
            icon: CupertinoIcons.wind_snow,
            title: 'Ventilación',
            valor: stateVentilador.isEmpty ? "N/a" : stateVentilador,
            signo: "",
          ),
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String signo;
  final String valor;

  const _SingleCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    this.signo = '%',
    this.valor = "0",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(
      child: _BodyCardBackground(
          color: color, icon: icon, valor: valor, title: title, signo: signo),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                color: const Color.fromARGB(113, 17, 18, 30),
                borderRadius: BorderRadius.circular(30)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _BodyCardBackground extends StatelessWidget {
  const _BodyCardBackground({
    Key? key,
    required this.color,
    required this.icon,
    required this.valor,
    required this.title,
    required this.signo,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final String? valor;
  final String title;
  final String signo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icon,
                size: 35,
                color: Colors.white,
              ),
              radius: 22,
            ),
            const SizedBox(width: 5),
            Text('$valor$signo',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 30)),
          ],
        ),
        const SizedBox(height: 10),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18))
      ],
    );
  }
}
