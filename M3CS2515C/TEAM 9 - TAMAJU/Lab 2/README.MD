# Lab Work 2

## Login Page

1. Group of 3
2. Using Flutter a framework and Dart as a programming language.
3. Using Android Studio or VS Code to create login page.
4. Run.
5. Make a documentation.

### Instruction

1.	Open your Visual Studio Code
2.	Ctrl + Shift + P and Click Flutter: New Project
3.	Select a folder
4.	Create a new name for login application
5.	Create a folder under lib named screen and under screen folder named login.dart
6.	Copy and paste this code
```
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      // Pass the user's email to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userEmail: usernameController.text),
        ),
      );
    } catch (e) {
      // Handle login errors, e.g., display an error message
      print('Login error: $e');
    }
  }

  void navigateToRegister() {
    // Navigate to the registration screen
    Navigator.pushNamed(context, '/register');
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/p2.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: navigateToRegister,
                child: Text('Not registered yet? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
7.	Run
8.	Output: A complete login page interface
