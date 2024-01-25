# Lab 7

## Insert Button Delete

### Youtube Link https://youtu.be/Zacq5b9lrLM

### Code Snippet foodpage.dart 

```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('food_items');

  final TextEditingController _foodController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addFoodItemToFirestore(String newItem) async {
    try {
      await foodCollection.add({'name': newItem});
      _foodController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add food: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> updateFoodItemInFirestore(String oldItem, String newItem) async {
    try {
      QuerySnapshot querySnapshot =
          await foodCollection.where('name', isEqualTo: oldItem).get();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.update({'name': newItem});
        });
        _foodController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food not found for update.'),
            backgroundColor: Colors.yellow,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update food: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteFoodItemFromFirestore(String itemToDelete) async {
    try {
      QuerySnapshot querySnapshot =
          await foodCollection.where('name', isEqualTo: itemToDelete).get();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
        _foodController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food deleted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food not found for deletion.'),
            backgroundColor: Colors.yellow,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete food: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _foodController,
                decoration: const InputDecoration(
                  labelText: 'Food Item',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a food item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addFoodItemToFirestore(_foodController.text);
                  }
                },
                child: const Text('Add Food'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateFoodItemInFirestore('oldItem', _foodController.text);
                  }
                },
                child: const Text('Update Food'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    deleteFoodItemFromFirestore(_foodController.text);
                  }
                },
                child: const Text('Delete Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
