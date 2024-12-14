import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeightLossPage extends StatefulWidget {
  @override
  _WeightLossPageState createState() => _WeightLossPageState();
}

class _WeightLossPageState extends State<WeightLossPage> {
  final String appId = "fb94c8fc";  // Replace with your Nutritionix App ID
  final String appKey = "4b127d50af4b0b5f99560745b91f64c4"; // Replace with your Nutritionix App Key

  late Future<List<dynamic>> exercises;
  late Future<List<dynamic>> nutritionPlans;

  @override
  void initState() {
    super.initState();
    exercises = fetchExercises();
    nutritionPlans = fetchNutritionPlans();
  }

  // Generalized fetchExercises function
  Future<List<dynamic>> fetchExercises() async {
    final response = await http.post(
      Uri.parse("https://trackapi.nutritionix.com/v2/natural/exercise"),
      headers: {
        'x-app-id': appId,
        'x-app-key': appKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "query": "weight loss exercises",  // General query without specific parameters
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('exercises')) {
        return responseData['exercises'];
      } else {
        throw Exception("Exercises data not found in response.");
      }
    } else {
      throw Exception("Failed to load exercises. Status code: ${response.statusCode}");
    }
  }

  // Fetch nutrition plans
  Future<List<dynamic>> fetchNutritionPlans() async {
    final response = await http.get(
      Uri.parse("https://trackapi.nutritionix.com/v2/search/instant?query=salad"),
      headers: {
        'x-app-id': appId,
        'x-app-key': appKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('common')) {
        return responseData['common'];
      } else {
        throw Exception("Nutrition plans data not found in response.");
      }
    } else {
      throw Exception("Failed to load nutrition plans. Status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weight Loss Plan",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          children: [
            _buildSection(
              title: "Exercises for Weight Loss",
              futureData: exercises,
              icon: Icons.fitness_center,
            ),
            SizedBox(height: 10),
            _buildSection(
              title: "Nutrition Plans for Weight Loss",
              futureData: nutritionPlans,
              icon: Icons.restaurant_menu,
            ),
          ],
        ),
      ),
    );
  }

  // Building sections for Exercises and Nutrition Plans
  Widget _buildSection({
    required String title,
    required Future<List<dynamic>> futureData,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.teal[800],
          ),
        ),
        children: [
          FutureBuilder<List<dynamic>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: snapshot.data!.map<Widget>((item) {
                    // Check for name and description in common fields or fallback to other fields
                    final name = item['name'] ?? item['food_name'] ?? 'No Name';

                    // Check description availability, fall back to food_type if not found
                    final description = item['description'] ?? item['food_type'] ?? 'No Description Available';

                    // Log the entire item to see what data is available (for debugging)
                    print(item);

                    return ListTile(
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        description,
                        style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
