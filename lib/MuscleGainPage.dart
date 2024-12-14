import 'package:app_auth/exercise_detail_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MuscleGainPage extends StatefulWidget {
  @override
  _MuscleGainPageState createState() => _MuscleGainPageState();
}

class _MuscleGainPageState extends State<MuscleGainPage> {
  List exercises = [];
  bool isLoading = true;
  String selectedBodyPart = 'back'; // Default body part

  // List of all body parts
  List<String> bodyParts = [
    'back',
    'chest',
    'legs',
    'shoulders',
    'arms',
    'core',
    'cardio',
    'stretching',
    'full body'
  ];

  @override
  void initState() {
    super.initState();
    fetchExercises(selectedBodyPart); // Fetch exercises for the default body part
  }

  Future<void> fetchExercises(String bodyPart) async {
    const String apiUrl =
        'https://exercisedb.p.rapidapi.com/exercises/bodyPart/';
    const Map<String, String> headers = {
      'X-RapidAPI-Key': 'f69707cce5msh59a1bd21ca8971dp1c2819jsn3dcf4ad2a96f', // Replace with your API key
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };

    try {
      final response =
      await http.get(Uri.parse(apiUrl + bodyPart), headers: headers);

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        setState(() {
          exercises = json.decode(response.body);
          isLoading = false;
        });
        print(response);
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      print("Error fetching exercises: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Muscle Gain Exercises'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedBodyPart,
              onChanged: (String? newBodyPart) {
                setState(() {
                  selectedBodyPart = newBodyPart!;
                  isLoading = true;
                });
                fetchExercises(selectedBodyPart); // Fetch exercises for new body part
              },
              items: bodyParts.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value[0].toUpperCase() + value.substring(1)),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : exercises.isEmpty
                ? Center(child: Text('No exercises found.'))
                : ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.fitness_center, color: Colors.teal, size: 30),
                    title: Text(
                      exercises[index]['name'] ?? 'Exercise',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Equipment: ${exercises[index]['equipment'] ?? 'None'}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailPage(
                            exercise: exercises[index], // Pass the selected exercise data
                          ),
                        ),
                      );
                    },
                  ),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
