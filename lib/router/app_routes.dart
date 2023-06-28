import 'package:flutter/material.dart';

import 'package:greenhouse_project/models/models.dart';
import 'package:greenhouse_project/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

//Lista de screens
  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'Estado',
        name: 'Vista en Vivo',
        screen: const Text('Vista en vivo'),
        icon: Icons.online_prediction_outlined),
    MenuOption(
        route: 'Alert',
        name: 'Warning',
        screen: const Text('Alert Screen'),
        icon: Icons.online_prediction_outlined),
  ];
  //Agregando los screens
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (context) => const HomeScreen()});
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (context) => option.screen});
    }
    return appRoutes;
  }

  //Ongenerarte
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
