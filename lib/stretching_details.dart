import 'package:flutter/material.dart';

class ExerciseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const ExerciseDetailsPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise['name'] ?? 'Exercise Details',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise['name'] ?? 'Exercise Name',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Instructions:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              exercise['instructions'] ??
                  'No instructions provided for this exercise.',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Additional Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Type: ${exercise['type'] ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Difficulty: ${exercise['difficulty'] ?? 'Not specified'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Equipment: ${exercise['equipment'] ?? 'None'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
