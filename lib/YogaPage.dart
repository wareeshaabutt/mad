import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YogaPage extends StatefulWidget {
  @override
  _YogaPageState createState() => _YogaPageState();
}

class _YogaPageState extends State<YogaPage> {
  late Future<List<dynamic>> yogaPoses;

  @override
  void initState() {
    super.initState();
    yogaPoses = fetchYogaPoses();
  }

  // Fetch yoga poses from the Yoga API
  Future<List<dynamic>> fetchYogaPoses() async {
    const String apiUrl = 'https://yoga-api-nzy4.onrender.com/v1/categories';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Extract poses from the first category for simplicity
        return data[0]['poses']; // Access 'poses' array
      } else {
        throw Exception('Failed to load yoga poses');
      }
    } catch (e) {
      throw Exception('Error fetching poses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yoga Poses",
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
        child: FutureBuilder<List<dynamic>>(
          future: yogaPoses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No yoga poses available"));
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(12.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var pose = snapshot.data![index];

                  // Extract name and image URL
                  final poseName = pose['english_name'] ?? 'Unknown Pose';
                  final imageUrl = pose['url_png'] ?? '';

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: imageUrl.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                          : null,
                      title: Text(
                        poseName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
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
    );
  }
}
