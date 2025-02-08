
import 'package:mobile_project/data/vars.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_project/supabase/user.dart';
class Reciepe_Helper{

static Future<Map<dynamic,dynamic>> Get_Dish(int id)async{
    // final supabase = SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');

    // final response = await supabase.from("Reciepes").select("*").eq('id', id).limit(1).single();

    // return response;
  final url = Uri.parse('$baseUrl/api/recipes/Get_Dish/$id');
  try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        return Map<dynamic,dynamic>.from(data['dish']);  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return {};
    }

}



  static Future<List<Map<String,dynamic>>> Get_Category_Reciepes(int categoryId)async {
    // final supabase =SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');
    // final response = await supabase.from('Reciepes').select('id,title,subtitle,time,rating,media').eq('category', categoryId);
    // return response;

final url = Uri.parse('$baseUrl/api/recipes/Get_Category_Reciepes/$categoryId');

  try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        return List<Map<String,dynamic>>.from(data['reciepes']);  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return [];
    }
  }

  static Future<dynamic> Get_Dish_Media(mediaId)async {
    //  final supabase =SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');
    // final response = await supabase.from('Media').select('*').eq('id',mediaId).limit(1).single();
    // return response;

final url = Uri.parse('$baseUrl/api/recipes/Get_Dish_Media/$mediaId');
  try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['media'];  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return {};
    }
  }

  static Future<int> Get_num_reviews(int reciepeId)async {
//  final supabase =SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');
//     final response = await supabase.from('Reviews').select('id').eq('reciepe_id', reciepeId).count();
//     return response.count;

final url = Uri.parse('$baseUrl/api/recipes/Get_num_reviews/$reciepeId');
  try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body); 
        return data['num_reviews'];  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return 0;
    }

  }

  static Future<List<Map<String,dynamic>>> Get_Reciepes_By_Name(String name,bool limit)async {

  var l=0;
if (limit) {
l=1;}

  final url = Uri.parse('$baseUrl/api/recipes/Get_Reciepes_By_Name/$name/$l');

    try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return List<Map<String,dynamic>>.from(data['reciepes']);  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return [];
    }   
  }

 static Future<List<Map<String,dynamic>>> Get_Reciepes_By_Exact_ingredients(List<Map<String,dynamic>> ingridients)async {

var ingridients_='';
for(int i=0;i<ingridients.length;i++){
    ingridients_+='${ingridients[i]['ingridient']},';
}
ingridients_=ingridients_.substring(0,ingridients_.length-1);

  final url = Uri.parse('$baseUrl/api/recipes/Get_Reciepes_By_Exact_ingredients/$ingridients_');
    try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return  List<Map<String,dynamic>>.from(data['reciepes']);  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return [];
    } 
    
 }


  static Future<List<Map<String,dynamic>>> Get_Reciepes_By_Subset_ingredients(List<Map<String,dynamic>> ingridients)async {

  var ingridients_='';
  for(int i=0;i<ingridients.length;i++){
    ingridients_+='${ingridients[i]['ingridient']},';
  }
  ingridients_=ingridients_.substring(0,ingridients_.length-1);

final url = Uri.parse('$baseUrl/api/recipes/Get_Reciepes_By_Subset_ingredients/$ingridients_');
    try {
      // Send GET request to Flask API
      final response = await http.get(url);
      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return List<Map<String,dynamic>>.from(data['reciepes']);  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return [];
    }
 }











 static Future<List<Map<String,dynamic>>> Get_Reciepes_By_Exact_ingredients_and_quantity(List<Map<String,dynamic>> ingridients)async {


var ingridients_='';
for(int i=0;i<ingridients.length;i++){
    ingridients_+='${ingridients[i]['ingridient']}_${ingridients[i]['quantity']},';

}
ingridients_=ingridients_.substring(0,ingridients_.length-1);

final url = Uri.parse('$baseUrl/api/recipes/Get_Reciepes_By_Exact_ingredients_and_quantity/$ingridients_');

try {
    // Send GET request to Flask API
    final response = await http.get(url);
    // Check for successful response
    if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return List<Map<String,dynamic>>.from(data['reciepes']);  // Get the image URL from the response
    } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return [];
    }
} catch (e) {
    print('Error fetching image URL: $e');
    return [];
} }}





//----------------------------------------------------import 'dart:convert';


Future<void> addRecipe({
  required String category,
  required String title,
  required String details,
  required List<String> steps,
  required List<String> ingredients,
  required List<String> nutritionalValues,
  required String time,
  required double rating,
  required String userId,
  required String subtitle,
  required List<String> quantity,
  String? videoBase64, 
  List<String>? imageBase64List, 
}) async {
  final String url = "https://fc0a-41-111-187-84.ngrok-free.app/api/recipes/add_recipe";

  final Map<String, dynamic> data = {
    "category": category,
    "title": title,
    "details": details,
    "steps": steps,
    "ingridients": ingredients, 
    "nutritional_val": nutritionalValues,
    "time": time,
    "rating": rating,
    "user_id": userId,
    "subtitle": subtitle,
    "quantity": quantity,
    if (videoBase64 != null) "video": videoBase64, 
    if (imageBase64List != null && imageBase64List.isNotEmpty) "images": imageBase64List, 
  };
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("Recipe added successfully: ${response.body}");
    } else {
      print("Failed to add recipe: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Error adding recipe: $e");
  }
}




Future<Map<String, dynamic>?> getUserRecipes(String userId) async {
  userId = await UserHelper.getCurrentUser(); 
  final String url = "$baseUrl/api/recipes/user_recipes/$userId";

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData; 
    } else {
      print("Failed to retrieve recipes: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error retrieving recipes: $e");
    return null;
  }
}


Future<Map<String, dynamic>?> getUserFavorites(String userId) async {
  userId = await UserHelper.getCurrentUser();
  final String url = "$baseUrl/api/users/user_favorites/$userId";

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData; 
    } else {
      print("Failed to retrieve favorite recipes: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error retrieving favorite recipes: $e");
    return null;
  }
}


