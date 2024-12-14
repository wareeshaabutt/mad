import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://wger.de/api/v2/workout/';
  final String token =
      '45b4a0fd9f0417ef2df6eb288305cf02401fe1fd'
  ; // Replace with your token

  // Function to get headers for API calls
  Map<String, String> getHeaders() {
    return {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
  }

  // Fetch Weight Loss Exercises
  Future<List<dynamic>> fetchWeightLossExercises() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: getHeaders());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Fetched Weight Loss Exercises: $data'); // Print the fetched data
        return data['results']; // Assuming API response has a 'results' key
      } else {
        throw Exception('Failed to load exercises. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exercises: $e');
      rethrow; // Re-throw the error to be handled in the UI
    }
  }

  // Fetch Weight Loss Nutrition Plans (Placeholder)
  Future<List<dynamic>> fetchWeightLossNutrition() async {
    // Placeholder data (replace with real API call when available)
    final data = [
      {"name": "Low Carb Plan", "description": "Reduce carbs and eat more protein."},
      {"name": "Intermittent Fasting", "description": "Fast for 16 hours and eat in 8-hour window."},
    ];
    print('Fetched Weight Loss Nutrition Plans: $data'); // Print the fetched data
    return data;
  }

  // Fetch Weight Loss Meals (Placeholder)
  Future<List<dynamic>> fetchWeightLossMeals() async {
    // Placeholder data (replace with real API call when available)
    final data = [
      {"name": "Grilled Chicken Salad", "description": "High protein with greens."},
      {"name": "Oatmeal with Fruits", "description": "Rich in fiber and vitamins."},
    ];
    print('Fetched Weight Loss Meals: $data'); // Print the fetched data
    return data;
  }

  static const String _apiKey = "YqLShMC34MwPrwCplIxjDw==LUIraAobZQTBjbmC";
  static const String _baseUrl = "https://api.api-ninjas.com/v1/exercises";

  /// Fetches exercises of type 'stretching' from the API.
  Future<List<dynamic>> fetchStretchingExercises() async {
    final url = Uri.parse("$_baseUrl?type=stretching");

    try {
      final response = await http.get(
        url,
        headers: {
          'X-Api-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        // Handle errors
        throw Exception(
          'Failed to load exercises: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Error fetching exercises: $e');
    }
  }

  Future<List<dynamic>> fetchYogaCategories() async {
    const String apiUrl = 'https://yoga-api-nzy4.onrender.com/v1/categories';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        // Decode the response body into a List
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        // Handle API errors
        throw Exception("Failed to load categories: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw Exception("An error occurred: $e");
    }
  }
}
