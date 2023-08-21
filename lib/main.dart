import 'package:flutter/material.dart';
import 'package:weather/screen/Temprature_screen.dart';
import 'package:weather/screen/loading_screen.dart';
import 'package:weather/splaceScreen/Splace_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplaceScreen());
  }
}
