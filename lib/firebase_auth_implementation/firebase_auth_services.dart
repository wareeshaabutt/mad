import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up method
  Future<User?> signupWithEmailAndPassword(String email, String password, String name) async {
    try {
      // Create user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;

      // After user creation, update user profile with the name
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = _auth.currentUser;  // Reload user to get the updated info
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // Detailed error handling
      if (e.code == 'email-already-in-use') {
        print("The email is already registered. Please try logging in.");
      } else if (e.code == 'invalid-email') {
        print("The email address is not valid.");
      } else if (e.code == 'weak-password') {
        print("The password is too weak. Please choose a stronger password.");
      } else {
        print("Firebase Auth Exception: ${e.code} - ${e.message}");
      }
    } catch (e) {
      print("General Exception: ${e.toString()}");
    }
    return null;
  }

  // Sign in method
  Future<User?> signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Detailed error handling
      if (e.code == 'user-not-found') {
        print("No user found with this email. Please sign up.");
      } else if (e.code == 'wrong-password') {
        print("Incorrect password. Please try again.");
      } else if (e.code == 'invalid-email') {
        print("The email address is not valid.");
      } else {
        print("Firebase Auth Exception: ${e.code} - ${e.message}");
      }
    } catch (e) {
      print("General Exception: ${e.toString()}");
    }
    return null;
  }
}
