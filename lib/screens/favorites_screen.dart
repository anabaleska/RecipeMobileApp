import 'package:flutter/material.dart';
import 'package:recipe_app/services/favorites_service.dart';

import '../widgets/MealCard.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() {
    return FavoritesScreenState();
  }
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final favorites = FavoritesService.favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(
            color: Colors.deepOrange.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 246, 157, 129),
                Color.fromARGB(255, 255, 183, 128),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      body: favorites.isEmpty
          ? Center(
              child: Text(
                "No favorite meals yet",
                style: TextStyle(
                  color: Colors.deepOrange.shade900,
                  fontSize: 16,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return MealCard(meal: favorites[index]);
              },
            ),
    );
  }
}
