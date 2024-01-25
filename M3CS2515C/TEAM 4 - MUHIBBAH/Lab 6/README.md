# Lab 6

## Create Update Page for user information and other information.

### Youtube Link https://youtu.be/H8ta1Ibkc4s

### Code Snippet dashboard.dart

```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_creation_page.dart';
import 'updateProfile.dart';
import 'orderfood.dart'; // Import the OrderFoodPage class

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  Future<void> _deleteProfile(String profileId) async {
    // Add the logic to delete the profile locally without changing the Cloud Firestore data
    // For demonstration purposes, this function just prints the ID of the profile to be deleted
    print('Deleting profile with ID: $profileId');
  }

  void _updateProfile(BuildContext context, String profileId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfilePage(profileId: profileId),
      ),
    );
  }

  void _navigateToOrderFood(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderFoodPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Dota 2'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('profiles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final profiles = snapshot.data!.docs;
            return ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(profiles[index].id),
                  onDismissed: (direction) {
                    _deleteProfile(profiles[index].id);
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                  ),
                  child: Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      title: Text(
                        profiles[index]['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        profiles[index]['occupation'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Age: ${profiles[index]['age']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Address: ${profiles[index]['address']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                _updateProfile(context, profiles[index].id);
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.blue, // text color
                              ),
                              child: const Text('Update'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileCreationPage()),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
            child: const Icon(Icons.logout),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              _navigateToOrderFood(context);
            },
            child: const Icon(Icons.fastfood),
          ),
        ],
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}
```

### Code Snippet firebase_option.dart

```dart
// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for Ruse with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlS1NFRl5ABXzf4PUpxykS94LbtB-i2kQ',
    appId: '1:258071770927:android:ce5c2e4753822ad37c53da',
    messagingSenderId: '258071770927',
    projectId: 'muhibbah-6a320',
    storageBucket: 'muhibbah-6a320.appspot.com',
  );
}
```
