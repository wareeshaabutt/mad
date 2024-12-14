import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user from Firebase
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is logged in
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Account",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
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
        padding: EdgeInsets.all(16),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal.shade100,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildInfoRow("Name", user.displayName ?? "No name provided"),
            _buildInfoRow("Email", user.email ?? "No email provided"),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Go Back",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
