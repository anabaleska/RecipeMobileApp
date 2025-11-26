import 'package:flutter/material.dart';
import 'package:recipe_app/screens/main_screen.dart';
import 'package:recipe_app/screens/meal_details.dart';
import 'package:recipe_app/screens/meal_screen.dart';
import 'package:recipe_app/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      routes: {
        "/meal_screen": (context) => MealScreen(),
        "/meal_details": (context) => MealDetails()},
    );
  }
}
