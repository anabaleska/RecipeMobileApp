import 'package:flutter/material.dart';
import 'package:recipe_app/models/MealDetail.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key});

  @override
  State<MealDetails> createState() => MealDetailsState();
}

class MealDetailsState extends State<MealDetails> {
  final ApiService _apiService = ApiService();
  late final MealDetail _mealDetail;
  late final String _mealId;
  bool _isLoading = true;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      _mealId = ModalRoute.of(context)!.settings.arguments as String;
      loadMealDetails();
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLoading
            ? Text(
          "",
          style: TextStyle(
            color: Colors.deepOrange.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        )
            : Text(
          _mealDetail.strMeal ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(_mealDetail.strMealThumb ?? ""),
            ),
            const SizedBox(height: 20),

            Text(
              "Ingredients",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
            const SizedBox(height: 10),

            ..._mealDetail.ingredients.entries.map(
                  (e) => Text(
                "- ${e.key}: ${e.value}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Instructions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              _mealDetail.strInstructions ?? "",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            if (_mealDetail.strYoutube != null &&
                _mealDetail.strYoutube!.trim().isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final Uri youtubeUri =
                    Uri.parse(_mealDetail.strYoutube!.trim());
                    try {
                      await launchUrl(
                        youtubeUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Cannot open the link.')),
                        );
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.deepOrange.shade900,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: Icon(
                    Icons.play_circle,
                    color: Colors.deepOrange.shade900,
                  ),
                  label: Text(
                    "Watch on YouTube",
                    style: TextStyle(
                      color: Colors.deepOrange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void loadMealDetails() async {
    final MealDetail mealDetail = await _apiService.loadMealDetails(_mealId);
    setState(() {
      _mealDetail = mealDetail;
      _isLoading = false;
    });
  }
}
