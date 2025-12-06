import 'package:flutter/material.dart';
import '../models/Meal.dart';
import '../services/favorites_service.dart';

class MealCard extends StatefulWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    final bool isFav =
    FavoritesService.isFavorite(widget.meal);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/meal_details",
          arguments: widget.meal.idMeal,
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.orange.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.deepOrange.shade200, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                widget.meal.strMealThumb,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),


            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.meal.strMeal,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange.shade900,
                    ),
                  ),
                ),),
                 IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 26,
                    ),
                    onPressed: () {
                      setState(() {
                        FavoritesService.toggleFavorite(widget.meal);
                      });
                    },
                  ),

              ],
            ),


            const Spacer(),
          ],
        ),
      ),
    );
  }
}
