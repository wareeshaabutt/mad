import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Map exercise; // Data of the selected exercise

  ExerciseDetailPage({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise['name'] ?? 'Exercise Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise Name:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              exercise['name'] ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Body Part:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              exercise['bodyPart'] ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Target Muscle:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              exercise['target'] ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Equipment:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              exercise['equipment'] ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'GIF URL:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            exercise['gifUrl'] != null
                ? Image.network(
              exercise['gifUrl'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Text('No image available'),
          ],
        ),
      ),
    );
  }
}
