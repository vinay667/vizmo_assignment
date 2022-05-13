import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vizmo_assignment/app_module.dart';
import 'package:vizmo_assignment/main.reflectable.dart';
import 'package:vizmo_assignment/screens/splash_screen.dart';

import 'screens/employee_home.dart';
import 'app_module.dart';

void main() {
  initializeReflectable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModularApp(module: AppModule(), child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    ));
  }
}

