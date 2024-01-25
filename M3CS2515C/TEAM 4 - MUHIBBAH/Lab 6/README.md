# Lab 6

## Create Update Page for user information and other information.

### Youtube Link https://youtu.be/H8ta1Ibkc4s

### Code Snippet

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
