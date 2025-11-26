class Meal {

  String idMeal;
  String strMeal;
  String strMealThumb;

  Meal(this.idMeal, this.strMeal, this.strMealThumb);

  Meal.fromJson(Map<String, dynamic> data)
      : idMeal = data['idMeal'],
      strMeal = data['strMeal'],
      strMealThumb = data['strMealThumb'];


}