class MealDetail {
  final String idMeal;
  final String? strMeal;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strYoutube;
  final Map<String, String> ingredients;

  MealDetail({
    required this.idMeal,
    this.strMeal,
    this.strInstructions,
    this.strMealThumb,
    this.strYoutube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> data) {
    Map<String, String> ing = {};

    for (int i = 1; i <= 20; i++) {
      String? ingredient = data['strIngredient$i'];
      String? measure = data['strMeasure$i'];

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ing[ingredient] = measure ?? "";
      }
    }

    return MealDetail(
      idMeal: data['idMeal'],
      strMeal: data['strMeal'],
      strMealThumb: data['strMealThumb'],
      strInstructions: data['strInstructions'],
      strYoutube: data['strYoutube'],
      ingredients: ing,
    );
  }
}
