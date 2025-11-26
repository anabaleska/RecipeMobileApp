import 'package:flutter/material.dart';
import '../models/Meal.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/meal_details", arguments: meal.idMeal);
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.orange.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.deepOrange.shade200,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                meal.strMealThumb,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                meal.strMeal,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:  Colors.deepOrange.shade900,
                ),
              ),
            ),

            const Spacer(),

          ],
        ),
      ),
    );
  }
}
