import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:greenhouse_project/services/user_services.dart';
import 'package:greenhouse_project/theme/app_theme.dart';

class CardControlTable extends StatelessWidget {
  const CardControlTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(children: [
          _SingleCard(
            icon: Icons.ac_unit_outlined,
            color: Colors.white,
            title: 'Control Ventilación',
            titleSwitch: 'Encender: ',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            icon: Icons.window_outlined,
            color: Colors.white,
            title: 'Control Ventanas',
            titleSwitch: 'Abrir:',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            icon: Icons.restaurant_menu_outlined,
            color: Colors.white,
            title: 'Control Alimentario 1',
            titleSwitch: 'Alimentar:',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            icon: Icons.restaurant_menu_outlined,
            color: Colors.white,
            title: 'Control Alimentario 2',
            titleSwitch: 'Alimentar:',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            icon: Icons.water,
            color: Colors.white,
            title: 'Control De Agua',
            titleSwitch: 'Activar:',
          )
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String titleSwitch;
  final int? valor;

  const _SingleCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    required this.titleSwitch,
    this.valor = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _cardBackground(
      child: CardGreenHouse(
        icon: icon,
        color: color,
        title: title,
        valor: valor,
        titleSwitch: titleSwitch,
      ),
    );
  }
}

class _cardBackground extends StatelessWidget {
  final Widget child;
  const _cardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(113, 17, 18, 30),
                      borderRadius: BorderRadius.circular(30)),
                  child: child,
                ))));
  }
}

class CardGreenHouse extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String titleSwitch;
  final int? valor;
  const CardGreenHouse(
      {Key? key,
      required this.icon,
      required this.color,
      required this.title,
      required this.titleSwitch,
      required this.valor})
      : super(key: key);

  @override
  State<CardGreenHouse> createState() => _CardGreenHouseState();
}

class _CardGreenHouseState extends State<CardGreenHouse> {
  int count = 0;
  bool _sliderEnable = false;
  String valueTemp = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: widget.color, fontSize: 22, fontWeight: FontWeight.bold)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.primary,
            child: Icon(
              widget.icon,
              size: 40,
              color: Colors.white,
            ),
            radius: 25,
          ),
          SizedBox(
            // color: Colors.red,
            //margin: EdgeInsets.all(10),
            width: size.width - 90,
            child: SwitchListTile.adaptive(
                activeColor: widget.color,
                title: Text(widget.titleSwitch,
                    style: TextStyle(color: widget.color)),
                value: _sliderEnable,
                onChanged: (value) => setState(() {
                      String nodo = "";
                      switch (widget.title) {
                        case "Control Ventilación":
                          nodo = "ventilador";
                          break;
                        case "Control Alimentario 1":
                          nodo = "alimentos1";
                          break;
                        case "Control Alimentario 2":
                          nodo = "alimentos2";
                          break;
                        case "Control Ventanas":
                          nodo = "ventanas";
                          break;
                        case "Control De Agua":
                          nodo = "agua";
                          break;
                        default:
                          "Switch no encontrado...";
                      }

                      _sliderEnable = value;

                      displayDialogAndroid(context);
                      print(
                          "_Slider enable: ${_sliderEnable} de ${widget.title}");
                      UserServices().setSwitch(
                        nodo,
                        _sliderEnable,
                      );
                    })),
          ),
        ],
      ),
    ]);
  }

  void displayDialogAndroid(BuildContext context) {
    String temp = "";

    if (_sliderEnable) {
      temp = "Activo";
    } else {
      temp = "Desactivo";
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Center(
              child: Text(
                'ALERTA',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(12)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$temp el ${widget.title}'),
                const SizedBox(height: 10),
                //FlutterLogo(size: 100),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ACEPTAR',
                      style: TextStyle(),
                    )),
              ),
            ],
          );
        }).then((value) {
      // temp = value;
    });
  }
}
