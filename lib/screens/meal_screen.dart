import 'package:flutter/material.dart';
import 'package:recipe_app/models/Category.dart';
import '../models/Meal.dart';
import '../services/api_service.dart';
import '../widgets/MealCard.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() {
    return MealScreenState();
  }
}

class MealScreenState extends State<MealScreen> {
  final ApiService _apiService = ApiService();
  late List<Meal> _meals;
  late List<Meal> _mealsBackup;
  late Category _category;
  bool _isLoading = true;
  bool _isInit = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      _category = ModalRoute.of(context)!.settings.arguments as Category;
      loadMeals();
      _isInit = true;
    }
  }

  void searchMeals(String query) {
    if (query.isEmpty) {
      setState(() {
        _meals = _mealsBackup;
      });
      return;
    }

    final filtered = _mealsBackup
        .where((m) => m.strMeal.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _meals = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _category.strCategory,
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.deepOrange.shade900,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites_screen');
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search meals...",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.deepOrange.shade900,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                      onChanged: (value) {
                        searchMeals(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: _meals.isEmpty
                      ? Center(
                          child: Text(
                            "No meals found",
                            style: TextStyle(
                              color: Colors.deepOrange.shade900,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.all(12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: _meals.length,
                          itemBuilder: (context, index) {
                            return MealCard(meal: _meals[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  void loadMeals() async {
    setState(() => _isLoading = true);
    final List<Meal> meals = await _apiService.loadMealList(_category);

    setState(() {
      _meals = meals;
      _mealsBackup = meals;
      _isLoading = false;
    });
  }
}
