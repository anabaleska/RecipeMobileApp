import 'dart:convert';
import 'package:recipe_app/models/MealDetail.dart';

import '../models/Category.dart';
import 'package:http/http.dart' as http;

import '../models/Meal.dart';

class ApiService {
  Future<List<Category>> loadCategoryList() async {
    List<Category> categoryList = [];

    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      final List categories = detailData['categories'];

      for (var category in categories) {
        categoryList.add(Category.fromJson(category));
      }
    }
    return categoryList;
  }

  Future<List<Meal>> loadMealList(Category category) async {
    List<Meal> mealList = [];

    final detailResponse = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=${category.strCategory}',
      ),
    );

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      final List meals = detailData['meals'];

      for (var meal in meals) {
        mealList.add(Meal.fromJson(meal));
      }
    }
    return mealList;
  }

  Future<MealDetail> loadMealDetails(String id) async {
    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      return MealDetail.fromJson(detailData['meals'][0]);
    } else {
      throw Exception("Failed to load meal detail");
    }
  }


  Future<MealDetail> loadRandomMeal() async {
    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      return MealDetail.fromJson(detailData['meals'][0]);
    } else {
      throw Exception("Failed to load meal detail");
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to search meals");
    }
  }
}
