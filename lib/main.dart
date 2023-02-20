import 'package:flutter/material.dart';
import "package:kitchen_calculator/pages/home.dart";
import 'package:kitchen_calculator/pages/energy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kitchen Kalculator',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const HomePage(title: 'Кухонний калькулятор'),
      routes: <String, WidgetBuilder>{
        Energy.route: (context) => const Energy(title: 'Калькулятор калорій'),
      },
    );
  }
}
