Lab Work 9
Google Sign-in
1. Group of 4
2. Create new project or use the existing.
3. Run the project on the smartphone or AVD.
4. Register to use Google Sign-in API on https://firebase.google.com/docs/android/setup. (See the instruction on https://pub.dev/packages/google_sign_in/install)
(more: https://pub.dev/packages/google_sign_in)
5. Create Google Sign-in Page/Screen.
6. Highlight on YouTube using the timestamps.
7. Github page README.md should highlight on VSCode final coding pages + Speedcode.
2310-ICT602

SpeedCode: https://www.youtube.com/watch?v=_7lhMO_gP9Y

Login page

_import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_602/firebase_auth_service.dart';
import 'package:flutter_602/home_page.dart';
import 'package:flutter_602/user_model.dart';
import 'package:flutter_602/registration_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                User? user = await FirebaseAuthService().signInWithEmailAndPassword(
                  _emailController.text,
                  _passwordController.text,
                );

                if (user != null) {
                  // Fetch user details from Firestore
                  AppUser? userDetails = await FirebaseAuthService().getUserDetails(user.uid);

                  if (userDetails != null) {
                    // Navigate to the home page with actual user details
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(user: userDetails)),
                    );
                  } else {
                    // Show error message if user details couldn't be fetched
                    print("Error fetching user details.");
                  }
                } else {
                  // Show login error message
                  print("Login failed.");
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await FirebaseAuthService().signInWithGoogle();

                if (user != null) {
                  // Fetch user details from Firestore
                  AppUser? userDetails = await FirebaseAuthService().getUserDetails(user.uid);

                  if (userDetails != null) {
                    // Navigate to the home page with actual user details
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(user: userDetails)),
                    );
                  } else {
                    // Show error message if user details couldn't be fetched
                    print("Error fetching user details.");
                  }
                } else {
                  // Show login error message
                  print("Google Sign-In failed.");
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
_


Sign-In / Login With Google fucntion

**firebase_auth_service.dart**
_Google Sign in Function

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        // Google sign-in canceled by the user
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      await _saveGoogleUserDataToFirestore(authResult.user!);
      return authResult.user;
    } catch (e) {
      print("Error during Google sign-in: $e");
      return null;
    }
  }

  Future<void> _saveGoogleUserDataToFirestore(User user) async {
    // Check if the user already exists in Firestore
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      // If the user does not exist, save their details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
        // Add other user details as needed
      });
    }
  }
_




