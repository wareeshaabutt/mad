import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'WeightLossPage.dart';
import 'MuscleGainPage.dart';
import 'YogaPage.dart';
import 'StretchingPage.dart';
import 'SubscriptionPage.dart';
import 'AcocountDetailsPage.dart';
import 'welcome_screen.dart';
import 'package:flutter/foundation.dart'; // Import kIsWeb for platform check
import 'pedometer.dart'; // Import pedometer.dart

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  String _status = 'unknown';
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    if (kIsWeb) {
      print("Pedometer is not supported on web platforms.");
      return;
    }

    // Listen to pedestrian status stream
    Pedometer.pedestrianStatusStream.listen((status) {
      setState(() {
        _status = status.status; // Update walking/stopped status
      });
    }).onError((error) {
      print("Error with pedestrian status: $error");
    });

    // Listen to step count stream
    Pedometer.stepCountStream.listen((step) {
      setState(() {
        _steps = step.steps; // Update step count
      });
    }).onError((error) {
      print("Error with step count: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return WelcomeScreen();
    }

    String displayName = user?.displayName ?? "User";
    String userEmail = user?.email ?? "No Email";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Your Training",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(displayName),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(displayName[0], style: TextStyle(fontSize: 24, color: Colors.teal)),
              ),
              decoration: BoxDecoration(color: Colors.teal),
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              title: Text('Subscriptions'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account Details'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Your Training Plan",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[700]),
            ),
            SizedBox(height: 20),
            _buildTrainingCard(
              title: "Weight Loss",
              color: Colors.teal,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WeightLossPage()));
              },
            ),
            _buildTrainingCard(
              title: "Muscle Gain",
              color: Colors.teal.shade400,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MuscleGainPage()));
              },
            ),
            _buildTrainingCard(
              title: "Yoga & Flexibility",
              color: Colors.teal.shade200,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => YogaPage()));
              },
            ),
            _buildTrainingCard(
              title: "Stretching",
              color: Colors.teal.shade100,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StretchingPage()));
              },
            ),
            Divider(height: 30, color: Colors.teal),
            _buildPedometerSection(), // Pedometer section added here
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingCard({required String title, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.fitness_center, color: Colors.white, size: 28),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Pedometer Section
  Widget _buildPedometerSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pedometer",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[700]),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Steps Taken:", style: TextStyle(fontSize: 16)),
              Text("$_steps", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status:", style: TextStyle(fontSize: 16)),
              Text("$_status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
