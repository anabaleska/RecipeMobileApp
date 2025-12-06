import 'package:flutter/material.dart';
import 'package:recipe_app/models/Category.dart';
import 'package:recipe_app/widgets/CategoryCard.dart';
import '../services/api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  final ApiService _apiService = ApiService();
  late final List<Category> _categories;
  bool _isLoading = true;
  List<Category> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where(
              (c) => c.strCategory.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              final randomMeal = await _apiService.loadRandomMeal();
              Navigator.pushNamed(
                context,
                '/meal_details',
                arguments: randomMeal.idMeal,
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.deepOrange.shade900),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Random Recipe",
              style: TextStyle(
                color: Colors.deepOrange.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.deepOrange.shade900),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites_screen');
            },
          ),
        ],
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
                        hintText: "Search categories...",
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
                        _filterCategories(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child:
                      _filteredCategories.isEmpty &&
                          _searchController.text.isNotEmpty
                      ? Center(
                          child: Text(
                            "No categories found",
                            style: TextStyle(
                              color: Colors.deepOrange.shade900,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredCategories.length,
                          itemBuilder: (context, index) {
                            final c = _filteredCategories[index];
                            return CategoryCard(category: c);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  void loadCategories() async {
    final List<Category> categories = await _apiService.loadCategoryList();

    setState(() {
      _categories = categories;
      _filteredCategories = categories;
      _isLoading = false;
    });
  }
}
