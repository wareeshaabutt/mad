import 'package:app_auth/stretching_details.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class StretchingPage extends StatefulWidget {
  const StretchingPage({super.key});

  @override
  State<StretchingPage> createState() => _StretchingPageState();
}

class _StretchingPageState extends State<StretchingPage> {
  late Future<List<dynamic>> _stretchingExercises;

  @override
  void initState() {
    super.initState();
    // Fetch exercises from the API
    _stretchingExercises = ApiService().fetchStretchingExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stretching Exercises',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Full-Body Stretching Routine',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Follow these simple stretches to relax your muscles and improve flexibility.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _stretchingExercises,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No stretching exercises available.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    // Print the fetched data in the terminal
                    print('Fetched Stretching Exercises: ${snapshot.data}');

                    // Display the fetched data in a ListView
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final exercise = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ExerciseDetailsPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseDetailsPage(exercise: exercise),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: const Icon(Icons.accessibility, color: Colors.teal),
                              title: Text(
                                exercise['name'] ?? 'No Name',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                exercise['instructions'] ?? 'No instructions available',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
