import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatefulWidget {
  final String tittle;
  final String subTitle;
  final Color textColor;

  const PageTitle({
    Key? key,
    required this.tittle,
    required this.subTitle,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  @override
  Widget build(BuildContext context) {
    bool stdSelected = false;
    return SafeArea(
      bottom: false,
      child: Container(
        // color: Colors.amber,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.tittle,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor),
                ),
                IconButton(
                  isSelected: stdSelected,
                  icon: const Icon(Icons.announcement_outlined),
                  selectedIcon: const Icon(Icons.announcement),
                  onPressed: () {
                    setState(() {
                      stdSelected = !stdSelected;
                    });
                    displayDialog(context);
                  },
                )
              ],
            ),
            //const SizedBox(height: 10),
            Text(widget.subTitle,
                style: TextStyle(
                    fontSize: 18,
                    color: widget.textColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  void displayDialog(BuildContext context) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Bienvenido a ChickenPalace",
                style: TextStyle(fontSize: 19)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "En la siguiente app podra monitorear, controlar y revizar el historial de lo sucedido en su criadero avicola.",
                  textAlign: TextAlign.justify,
                ),
                Text("Estado",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                    "En esta sección podra vizualizar el estado de las variables(Temperatura, Humedad, Agua, Amoniaco y Luz Ambiente) y de los actuadores (Dispensador de alimentos 1-2 y ventilacíon)",
                    textAlign: TextAlign.justify),
                Text("Controles",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                    "En esta sección podra ajustar el Umbral de la temperatura(Punto maximo de temperatura alcanzado por el criadero) o encender y apagar los actuadores(Control de ventilación, ventanas, alimentario 1-2 y agua) ",
                    textAlign: TextAlign.justify),
                Text("Historial",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                    "En esta sección podra vizualizar los datos capturados por los respectivos sensores, acompañado de su hora y fecha(Temperatura, Humedad y Agua)",
                    textAlign: TextAlign.justify),
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
}
