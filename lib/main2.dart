import 'dart:convert';
import 'package:http/http.dart' as http;


void main() async {
  // final String muscle = 'biceps';
  final String apiUrl = 'https://yoga-api-nzy4.onrender.com/v1/categories';
  // final String apiKey = 'YqLShMC34MwPrwCplIxjDw==LUIraAobZQTBjbmC';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      // headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Error: ${response.statusCode} - ${response.body} ");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}
