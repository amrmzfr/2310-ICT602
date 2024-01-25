# Lab 10
## RESTful API

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodListScreen(),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<dynamic> foods = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.0.10:8000/api/foods'));

    if (response.statusCode == 200) {
      setState(() {
        foods = jsonDecode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load foods: ${response.statusCode}');
    }
  }

  Future<void> addFood() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Food'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Send a POST request to add a new food item
                final response = await http.post(
                  Uri.parse('http://192.168.0.10:8000/api/foods'),
                  body: {
                    'name': nameController.text,
                    'price': priceController.text,
                  },
                );

                if (response.statusCode == 201) {
                  // Refresh the list after adding a new item
                  fetchData();
                } else {
                  // Handle error
                  print('Failed to add food: ${response.statusCode}');
                }

                Navigator.pop(context); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateFood(int index) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Food'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController..text = foods[index]['name'],
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController..text = foods[index]['price'].toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Send a PUT request to update the selected food item
                final response = await http.put(
                  Uri.parse('http://192.168.0.10:8000/api/foods/${foods[index]['id']}'),
                  body: {
                    'name': nameController.text,
                    'price': priceController.text,
                  },
                );

                if (response.statusCode == 200) {
                  // Refresh the list after updating the item
                  fetchData();
                } else {
                  // Handle error
                  print('Failed to update food: ${response.statusCode}');
                }

                Navigator.pop(context); // Close the dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteFood(int id) async {
    final response = await http.delete(Uri.parse('http://192.168.0.10:8000/api/foods/$id'));

    if (response.statusCode == 200) {
      // Refresh the list after deletion
      fetchData();
    } else {
      // Handle error
      print('Failed to delete food: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return ListTile(
            title: Text(food['name']),
            subtitle: Text('Price: \$${food['price']}'),
            onTap: () {
              // Implement navigation to the detail screen or other actions
              updateFood(index);
            },
            onLongPress: () {
              // Implement deletion when a food item is long-pressed
              deleteFood(food['id']);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addFood,
        child: Icon(Icons.add),
      ),
    );
  }
}
```
