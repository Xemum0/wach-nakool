import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:mobile_project/data/vars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart'; 
class UserHelper {
  // Get all users
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final url = Uri.parse('$baseUrl/api/users/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['users']);
      } else {
        print('Failed to fetch users. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  // Insert a new user
  static Future<bool> insertUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/api/users/users/insert');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);
      return response.statusCode == 201;
    } catch (e) {
      print('Error inserting user: $e');
      return false;
    }
  }

  // Update an existing user
  static Future<bool> updateUser(int id, Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/api/users/users/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Delete a user
  static Future<bool> deleteUser(int id) async {
    final url = Uri.parse('$baseUrl/api/users/users/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  // Get user by ID
  static Future<Map<String, dynamic>?> getUserById(int id) async {
    final url = Uri.parse('$baseUrl/api/users/users/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Map<String, dynamic>.from(data['user']);
      } else {
        print('Failed to fetch user. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }


  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final url = Uri.parse('$baseUrl/api/users/users/email/$email');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Map<String, dynamic>.from(data['user']);
      } else {
        print('Failed to fetch user. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  // Authenticate user (check email and password)
  static Future<Map<String, dynamic>?> authenticateUser(
      String email, String password) async {
    final url = Uri.parse('$baseUrl/api/users/users/authenticate');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['access_token']);
        return Map<String, dynamic>.from(data['user']);
      } else {
        print(
            'Failed to authenticate user. Status code: ${response.statusCode} url $baseUrl');
        return null;
      }
    } catch (e) {
      print('Error authenticating user: $e');
      return null;
    }
  }

  // Update user password
  static Future<bool> updatePassword(String email, String newPassword) async {
    final url = Uri.parse('$baseUrl/api/users/users/update_password');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'new_password': newPassword}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  // Get current logged-in user
  static Future<String> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null || email.isEmpty) {
      print('Email not found in SharedPreferences.');
      return '';
    }

    var user =  await getUserByEmail(
        email); 
    return user!['id'].toString();
  }



  static Future<Map> getfavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null || email.isEmpty) {
      print('Email not found in SharedPreferences.');
      return {};
    }

    var user=await getUserByEmail(email);
    if(user==null){
      return {};
    }
    
    var id=user['id'];
    final url = Uri.parse('$baseUrl/api/users/users/get_favourites/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List final_data=[];
        List ids=[];
        Map<String,dynamic> result={};
        for (int i=0;i<data['favourites'].length;i++){
          final_data.add((data['favourites'][i]['reciepe_id']));
          ids.add((data['favourites'][i]['id']));}
          result['favourites']=final_data;
          result['ids']=ids;
        return (result);
      } else {
        print('Failed to fetch Favourites. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error updating password: $e');

    }
    return {};
  }



    static Future<bool> remove_favourite(int id) async {

    final url = Uri.parse('$baseUrl/api/users/users/remove_favourites/$id');
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return (true);
      } else {
        print('Failed to fetch Favourites. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating password: $e');

    }
    return false;
  }



      static Future<bool> add_favourite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null || email.isEmpty) {
      print('Email not found in SharedPreferences.');
      return false;
    }

    var user=await getUserByEmail(email);
    if(user==null){
      return false;
    }
    
    var user_id=user['id'];
    final url = Uri.parse('$baseUrl/api/users/users/add_favourites/$user_id/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return (true);
      } else {
        print('Failed to fetch Favourites. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating password: $e');

    }
    return false;
  }

  static Future<void> deleteSharedVariable(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}


//---------------------------------------------------------



Future<void> updateUser({
  required String id,
  String? username,
  String? fullName,
  String? bio,
  String? profileImgBase64,
}) async {
  id = await UserHelper.getCurrentUser(); 

  final String url = "https://c99a-41-111-187-86.ngrok-free.app/api/users/update/$id";

  final Map<String, dynamic> data = {};

  if (username != null && username.isNotEmpty) data["username"] = username;
  if (fullName != null && fullName.isNotEmpty) data["full_name"] = fullName;
  if (bio != null && bio.isNotEmpty) data["bio"] = bio;

  // Check if the image is in base64 format before adding it
  if (profileImgBase64 != null && isBase64(profileImgBase64)) {
    data["profile_img"] = profileImgBase64;
  }

  print("Sending data: $data");

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("User updated successfully: ${response.body}");
    } else {
      print("Failed to update user: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Error updating user: $e");
  }
}



Future<Map<String, dynamic>?> getUserProfile(String userId) async {
  userId = await UserHelper.getCurrentUser(); 
  final String url = "$baseUrl/api/users/getme/$userId";

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey("user") && responseData["user"].isNotEmpty) {
        return responseData["user"][0]; 
      } else {
        print("No user data found.");
        return null;
      }
    } else {
      print("Failed to retrieve user profile: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error retrieving user profile: $e");
    return null;
  }
}