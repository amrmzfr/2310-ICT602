# Lab Work 9

## Google Sign-in

1. Group of 3
2. Create new project or use the existing.
3. Run the project on the smartphone or AVD.
4. Register to use Google Sign-in API on https://firebase.google.com/docs/android/setup. (See the instruction on https://pub.dev/packages/google_sign_in/install)
(more: https://pub.dev/packages/google_sign_in)
5. Create Google Sign-in Page/Screen.
6. Highlight on YouTube using the timestamps.

## LINK

https://youtu.be/G7KHWwJsEHQ

## LINK GITHUB

https://github.com/ismahhaziq/Flutter_Project

## CODE SNIPPET

#### Google Login Logic
```
  Future<void> _handleGoogleSignIn() async {
    try {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the Google Sign-In process
        return;
      }

      // Get Google Sign-In authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using Google credentials
      await _auth.signInWithCredential(credential);

      // Pass the user's email to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(userEmail: _auth.currentUser?.email ?? ""),
        ),
      );
    } catch (e) {
      print('Google Sign-In error: $e');
    }
  }
```

#### Google Login Button
```
      ElevatedButton(
                onPressed: _handleGoogleSignIn,
                child: Text('Login with Google'),
              ),
```

#### Add Dependency in Pubspec.yaml
```
  google_sign_in: ^6.1.6
```
