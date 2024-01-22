Lab Work 7
CRUD

1. Group of 4
2. Using VS Code use existing page insert button delete.
3. Using Firebase as a Database.
4. Try not to delete the data from database. It is just status show has being deleted.
5. The real delete action from database must be perform by an administrator only.
6. Run on Smartphone
7. Speed Code Video + Background Music.
8. Highlight on YouTube using the timestamps.
9. Github page README.md should highlight on VSCode final coding pages + Speedcode.



# GROUP:
M3CS2515C
AKMAL FARHAN BIN AHMAD ANNUAR (2022660498)

NURUL IFFAH HASYIMAH BINTI HASAN (2022457982)

ZUHAIRAH NURHIDAYAH BINTI ZAINUDIN (2022457722)

NURFADLIYANA 'AQILAH BINTI SULAIMAN (2022824754)

Youtube: https://youtu.be/CxC3G82waOs

```
Product Info Code that have deletion function on INTERFACE ONLY
class ProductInfoPage extends StatefulWidget {
  final User user;

  ProductInfoPage(this.user);

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  final TextEditingController drinkNameController = TextEditingController();
  final TextEditingController drinkDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Drink:",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextField(
              controller: drinkNameController,
              decoration: InputDecoration(
                labelText: "Drink Name",
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: drinkDescriptionController,
              decoration: InputDecoration(
                labelText: "Drink Description",
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Add new drink to Firestore with status 'active'
                await FirebaseFirestore.instance.collection('drinks').add({
                  'name': drinkNameController.text,
                  'description': drinkDescriptionController.text,
                  'userId': widget.user.uid,
                  'status': 'active', // Add the 'status' field
                });

                // Clear text fields
                drinkNameController.clear();
                drinkDescriptionController.clear();
              },
              child: Text("Add Drink"),
            ),
            SizedBox(height: 20),
            Text(
              "My Drinks:",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('drinks')
                    .where('userId', isEqualTo: widget.user.uid)
                    .where('status',
                        isEqualTo: 'active') // Filter out 'deleted' drinks
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var drinks = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      var drink = drinks[index].data() as Map<String, dynamic>;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(drink['name']),
                          subtitle: Text(drink['description']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // Update 'status' field to 'deleted'
                              await FirebaseFirestore.instance
                                  .collection('drinks')
                                  .doc(drinks[index].id)
                                  .update({'status': 'deleted'});
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

###FULL CODE VS CODE:
```
// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:labsir/product_info.dart'; // Import the new file
import 'package:labsir/user_info.dart'; // Import the new file

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Firebase is initialized before running the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF1E3F63),
        hintColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3F63)),
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF1E3F63),
            onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 18.0),
            padding: EdgeInsets.symmetric(vertical: 12.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Color(0xFF1E3F63),
            textStyle: TextStyle(fontSize: 16.0),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1E3F63),
        ),
      ),
      home: LoginPage(),
    );
  }
}

class MyAppInfo extends StatelessWidget {
  final User user;

  MyAppInfo(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Info"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuthService().signOut();
              Navigator.pop(context); // Navigate back to the login page
            },
          ),
        ],
      ),
      body: ProductInfoPage(user),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  final User user;

  UserInfoPage(this.user);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          fullNameController.text = userData['fullName'];
          emailController.text = userData['email'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full Name:",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                TextField(
                  controller: fullNameController,
                  readOnly: true,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 16),
                Text(
                  "Email:",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                TextField(
                  controller: emailController,
                  readOnly: true,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the edit page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUserInfoPage(widget.user)),
                    );
                  },
                  child: Text("Edit"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Show the dialog to change password
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Change Password"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: newPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Change password
                              await widget.user
                                  .updatePassword(newPasswordController.text);

                              // Close the dialog
                              Navigator.pop(context);
                            },
                            child: Text("Change"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Change Password"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditUserInfoPage extends StatelessWidget {
  final User user;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  EditUserInfoPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Full Name:",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextField(
              controller: fullNameController,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 16),
            Text(
              "Email:",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextField(
              controller: emailController,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Update user information in Firestore
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .update({
                  'fullName': fullNameController.text,
                  'email': emailController.text,
                });

                // Navigate back to user info page
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductInfoPage extends StatefulWidget {
  final User user;

  ProductInfoPage(this.user);

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  final TextEditingController drinkNameController = TextEditingController();
  final TextEditingController drinkDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Drink:",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextField(
              controller: drinkNameController,
              decoration: InputDecoration(
                labelText: "Drink Name",
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: drinkDescriptionController,
              decoration: InputDecoration(
                labelText: "Drink Description",
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Add new drink to Firestore with status 'active'
                await FirebaseFirestore.instance.collection('drinks').add({
                  'name': drinkNameController.text,
                  'description': drinkDescriptionController.text,
                  'userId': widget.user.uid,
                  'status': 'active', // Add the 'status' field
                });

                // Clear text fields
                drinkNameController.clear();
                drinkDescriptionController.clear();
              },
              child: Text("Add Drink"),
            ),
            SizedBox(height: 20),
            Text(
              "My Drinks:",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('drinks')
                    .where('userId', isEqualTo: widget.user.uid)
                    .where('status',
                        isEqualTo: 'active') // Filter out 'deleted' drinks
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var drinks = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      var drink = drinks[index].data() as Map<String, dynamic>;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(drink['name']),
                          subtitle: Text(drink['description']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // Update 'status' field to 'deleted'
                              await FirebaseFirestore.instance
                                  .collection('drinks')
                                  .doc(drinks[index].id)
                                  .update({'status': 'deleted'});
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  User? user = await _authService.signInWithEmailAndPassword(
                    email,
                    password,
                  );
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductInfoPage(user),
                      ),
                    );
                  } else {
                    print("Login failed");
                  }
                },
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text("Don't have an account? Sign up"),
              ),
              ElevatedButton(
                onPressed: () async {
                  User? user = await _authService.signInWithGoogle();
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAppInfo(user),
                      ),
                    );
                  } else {
                    print("Google Sign-In failed");
                  }
                },
                child: Text("Sign In with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final fullName = fullNameController.text;
                  final email = emailController.text;
                  final password = passwordController.text;
                  User? user = await _authService.signUpWithEmailAndPassword(
                    email,
                    password,
                    fullName,
                  );

                  if (user != null) {
                    // Save additional user data to Firestore
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .set({
                      'fullName': fullName,
                      'email': email,
                      // Add more fields as needed
                    });

                    Navigator.pop(context); // Close the current signup page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    // Handle signup failure
                    print("Signup failed");
                  }
                },
                child: Text("Sign Up"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Already have an account? Log in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      return user;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = authResult.user;
      return user;
    } catch (e) {
      print("Signup error: $e");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? user = authResult.user;

      return user;
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  signOut() {}
}
```
