import 'package:flutter/material.dart';
import "package:kitchen_calculator/pages/home.dart";
import 'package:kitchen_calculator/pages/energy.dart';
import 'package:kitchen_calculator/pages/recipe.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        Recipe.route: (context) => const Recipe(title: 'Галицькі рецепти'),
      },
    );
  }
}
