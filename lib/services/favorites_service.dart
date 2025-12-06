import '../models/Meal.dart';

class FavoritesService {
  static final List<Meal> _favorites = [];

  static List<Meal> get favorites => _favorites;

  static bool isFavorite(Meal meal) {
    return _favorites.any((m) => m.idMeal == meal.idMeal);
  }

  static void toggleFavorite(Meal meal) {
    if (isFavorite(meal)) {
      _favorites.removeWhere((m) => m.idMeal == meal.idMeal);
    } else {
      _favorites.add(meal);
    }
  }
}
