# Lab Work 10

## RESTful API

1. Group of 3
2. Create new flutter project or use the existing.
3. Run the project on the smartphone or AVD.
4. Create new laravel project on XAMP/Laragon/Ubuntu/Docker.
5. Create REST API Using Laravel. (example: https://blog.treblle.com/how-to-create-rest-api-using-laravel/ )
6. Create Sample Database and perform REST API CRUD using Laravel. (example: https://techsolutionstuff.com/post/laravel-rest-api-crud-tutorial)
7. Integrate Laravel REST API into Flutter App.
(example: https://blog.codemagic.io/rest-api-in-flutter/ )
8. Highlight on YouTube using the timestamps.
9. Github page README.md should highlight on VSCode final coding pages + Speedcode.

## LINK

https://youtu.be/U0-ckJycaSQ

## CODE SNIPPET

#### main.dart

```
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
      title: 'Flutter Laravel CRUD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController itemNameController = TextEditingController();
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.56.1:8000/api/items'));

    if (response.statusCode == 200) {
      setState(() {
        items = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> createItem() async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/items'),
      body: {'name': itemNameController.text},
    );

    if (response.statusCode == 200) {
      fetchData();
      itemNameController.clear();
    } else {
      throw Exception('Failed to create item');
    }
  }

  Future<void> updateItem(int id, String newName) async {
    final response = await http.put(
      Uri.parse('http://192.168.56.1:8000/api/items/$id'),
      body: {'name': newName},
    );

    if (response.statusCode == 200) {
      fetchData();
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response =
        await http.delete(Uri.parse('http://192.168.56.1:8000/api/items/$id'));

    if (response.statusCode == 200) {
      fetchData();
    } else {
      throw Exception('Failed to delete item');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Laravel CRUD Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: createItem,
            child: Text('Add Item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Show a dialog to update the item
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Update Item'),
                                content: TextField(
                                  onChanged: (newName) {
                                    // Update the item name in the local list
                                    setState(() {
                                      items[index]['name'] = newName;
                                    });
                                  },
                                  controller: TextEditingController(
                                      text: items[index]['name']),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Call the updateItem function
                                      updateItem(items[index]['id'],
                                          items[index]['name']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Update'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Show a dialog to confirm item deletion
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Call the deleteItem function
                                      deleteItem(items[index]['id']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

```

#### api.php

```
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ItemController;

Route::get('/items', [App\Http\Controllers\ItemController::class, 'index']);
Route::post('/items', [App\Http\Controllers\ItemController::class, 'store']);
Route::put('/items/{id}', [App\Http\Controllers\ItemController::class, 'update']);
Route::delete('/items/{id}', [App\Http\Controllers\ItemController::class, 'destroy']);
```

#### ItemController.php

```
<?php

namespace App\Http\Controllers;

use App\Models\Item;
use Illuminate\Http\Request;

class ItemController extends Controller
{
    public function index()
    {
        $items = Item::all();
        return response()->json($items);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $item = Item::create($validatedData);

        return response()->json($item);
    }

    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $item = Item::findOrFail($id);
        $item->update($validatedData);

        return response()->json($item);
    }

    public function destroy($id)
    {
        $item = Item::findOrFail($id);
        $item->delete();

        return response()->json(['message' => 'Item deleted successfully']);
    }
}
```

#### Item.php
```
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    use HasFactory;

    public $table = 'items';

        protected $fillable = [
        'id','name',
        // Add other fields as needed
    ];
}
```

### Command

Don't forget to change the api URL, to your own ip address. You can get it through command panel. Run this command, ipconfig.

http://(change_here):8000/api/items

#### Run on Laravel side
```
php artisan serve --host=0.0.0.0
```

#### Run on Flutter side
```
flutter run
```
