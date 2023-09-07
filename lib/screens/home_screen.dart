import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:greenhouse_project/views/views.dart';
import 'package:greenhouse_project/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var connectivityResult;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      print("Sin internet....");
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sin conexión a Internet'),
          content: const Text(
              'Por favor, revise su conexión a Internet y vuelva a intentarlo.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = [
      const ViewData(),
      const ControlsGreenhouse(),
      const Record(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          //* Background-fondo
          Background(),
          IndexedStack(
            children: screen,
            index: selectedIndex,
          )
        ],
      ),
      bottomNavigationBar: _bottonNavigationBar(),
    );
  }

  BottomNavigationBar _bottonNavigationBar() {
    return BottomNavigationBar(
      elevation: 0,
      selectedItemColor: Colors.white,
      backgroundColor: const Color.fromRGBO(55, 57, 84, 1),
      unselectedItemColor: const Color.fromRGBO(116, 117, 152, 1),
      selectedFontSize: 20,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction_outlined), label: 'Estado'),
        BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined), label: 'Controles'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
      ],
      currentIndex: selectedIndex,
      onTap: (value) {
        setState(() {
          selectedIndex = value;
          print('SelectedIndex: $selectedIndex');
        });
      },
    );
  }
}
