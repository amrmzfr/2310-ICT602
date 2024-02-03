Lab Work 10
RESTful API
1. Group of 4
2. Create new flutter project or use the existing.
3. Run the project on the smartphone or AVD.
4. Create new laravel project on XAMP/Laragon/Ubuntu/Docker.
5. Create REST API Using Laravel. (example: https://blog.treblle.com/how-to-create-rest-api-using-laravel/ )
6. Create Sample Database and perform REST API CRUD using Laravel. (example: https://techsolutionstuff.com/post/laravel-rest-api-crud-tutorial)
7. Integrate Laravel REST API into Flutter App.
(example: https://blog.codemagic.io/rest-api-in-flutter/ )
8. Highlight on YouTube using the timestamps.
9. Github page README.md should highlight on VSCode final coding pages + Speedcode.


video:
https://www.youtube.com/watch?v=vKlB5EUxAZU


Flutter Side

Getting data from Laravel Side
**food_api.dart**
```
// food_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab_10/food_model.dart';

class FoodApi {
  static const String apiUrl = "http://10.0.2.2:8000/api/foods";

  static Future<List<Food>> fetchFoods() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((food) => Food.fromJson(food)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  static Future<Map<String, dynamic>> fetchFoodById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load food');
    }
  }

  static Future<void> addFood(Map<String, String> body) async {
    final response = await http.post(Uri.parse(apiUrl), body: body);

    if (response.statusCode != 201) {
      throw Exception('Failed to add food');
    }
  }

  static Future<void> updateFood(int id, Map<String, String> body) async {
    final response = await http.put(Uri.parse('$apiUrl/$id'), body: body);

    if (response.statusCode != 200) {
      throw Exception('Failed to update food');
    }
  }

  static Future<void> deleteFood(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete food');
    }
  }
}
```

-----------------------------------------------------------------------------------------------------------------------------------------------------------

Laravel Side

For Database
**Models/Food.php**
```
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Food extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'description', 'price'];
}
```


For CRUD function

**Controller/FoodController.php**
```
<?php

namespace App\Http\Controllers;

use App\Models\Food;
use Illuminate\Http\Request;

class FoodController extends Controller
{
    public function index()
    {
        return Food::all();
    }

    public function show($id)
    {
        return Food::findOrFail($id);
    }

    public function store(Request $request)
    {
        return Food::create($request->all());
    }

    public function update(Request $request, $id)
    {
        try {
            $food = Food::findOrFail($id);
        
            $request->validate([
                'name' => 'required|string|max:255',
                'description' => 'required|string',
                'price' => 'required|numeric',
            ]);

            $food->update($request->all());

            return $food;
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to update food. ' . $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $food = Food::findOrFail($id);
            $food->delete();
    
            return response()->json([], 204);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to delete food. ' . $e->getMessage()], 500);
        }
    }
    
}
```

For connecting to local server
**route/api.php**
```
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FoodController;



/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::resource('foods', FoodController::class);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
```
