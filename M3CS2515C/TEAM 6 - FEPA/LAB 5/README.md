Lab Work 5
CRUD
 -
1. Group of 4
2. Using VS Code create the information page detail form.
3. Using Firebase as a Database.
4. Speed Code Video + Music.
5. Create Page for User Information.
6. Create Page for other information (e.g. Product, Transaction, Course or Department)
7. Run on AVD
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.


speedcode video: https://www.youtube.com/watch?v=4A3rif3_-rk

```
// food_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_602/food_model.dart';

class FoodDetailsPage extends StatelessWidget {
  final Food food;

  FoodDetailsPage({required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Name: ${food.name}'),
          Text('Description: ${food.description}'),
          Text('Price: \$${food.price}'),
          // Add more food details if needed
        ],
      ),
    );
  }
}
```

```
// user_profile_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_602/user_model.dart';

class UserProfilePage extends StatelessWidget {
  final AppUser user;

  UserProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Email: ${user.email}'),
          Text('Name: ${user.name}'),
          Text('Age: ${user.age}'),
          // Add more user profile details if needed
        ],
      ),
    );
  }
}
```
