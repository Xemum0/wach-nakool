
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/vars.dart';
class Categories_Helper
{
static Future<dynamic> GetData() async {
    // final supabase =SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');
    // print('successfully connected');
    // final response= await supabase.from('Category').select('*');
    // supabase.dispose();
    // return response;
    final url = Uri.parse('$baseUrl/api/categories/GetData');
    try {
      // Send GET request to Flask API
      final response = await http.get(url);

      // Check for successful response
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['categories'];  // Get the image URL from the response
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return [];
    }
  
}
static Future<List<Map<dynamic,dynamic>>> GetCategoriesNames() async {
    // final supabase =SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');
    // print('successfully connected');
    // final response= await supabase.from('Category').select('id,category');
    // supabase.dispose();
    // return response;
  
  final url = Uri.parse('$baseUrl/api/categories/GetCategoriesNames');

  try {
    // Send GET request to Flask API
    final response = await http.get(url); 
    // Check for successful response
    if (response.statusCode == 201) {
      //get the json response
      final data = jsonDecode(response.body);
      List<Map<dynamic, dynamic>> dat=List<Map<dynamic, dynamic>>.from(data['categories']);

return dat;

    } else {
      print('Failed to fetch  URL. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching image URL: $e');
    return [];
  }
}

  // static Future<dynamic> Get_Image(data) async{
  //   final supabase =SupabaseClient('https://leerygjkvxnmesgnaiit.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlZXJ5Z2prdnhubWVzZ25haWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTUxNTcsImV4cCI6MjA0OTMzMTE1N30.unNkWDmWvefen7QebVH00aqcgGcX6Y-058KyIBic8zA');
  //   print('successfully connected');
  //   final  image = await supabase.storage.from('Images').download(data);
  //   print('====================================================================================');
  //   supabase.dispose();
  //   return image;
  // }
}

