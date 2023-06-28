import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:greenhouse_project/router/app_routes.dart';
import 'package:greenhouse_project/screens/screens.dart';
import 'package:greenhouse_project/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      //initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Hubo un error: ${snapshot.error.toString()}");
              return const Text("Algo salio mal.");
            } else if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      theme: AppTheme.lightTheme,
    );
  }
}
