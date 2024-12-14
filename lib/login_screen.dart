import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
import 'firstpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(); // Controller for name
  bool _isNameRequired = false; // To check if name is required

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;

    try {
      // Sign in the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Check if the user has a name
        if (user.displayName == null || user.displayName!.isEmpty) {
          // If name is missing, use the name provided in the text field
          if (name.isNotEmpty) {
            // Update the user's name
            await user.updateDisplayName(name);
          }
        }

        // Navigate to the first page on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided.";
      } else {
        errorMessage = "Error: ${e.message}";
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Failed"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Try Again"),
            ),
          ],
        ),
      );
    } catch (e) {
      print("General Exception: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00796B), // Teal Gradient Top
              Color(0xFF004D40), // Darker Teal Bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            width: 350,
            height: 500,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Name Input (only if required)
                if (_isNameRequired) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Color(0xFF00796B)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00796B)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],

                // Email Input
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xFF00796B)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00796B)),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xFF00796B)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00796B)),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00796B),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _login,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Sign Up Option
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
