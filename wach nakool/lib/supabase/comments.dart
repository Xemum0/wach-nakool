import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_project/data/vars.dart';

class CommentsHelper {
  // Insert a new comment
  static Future<bool> insertComment({
    required String recipeId,
    required String comment,
    required String rating,
    required String token, // Add JWT Token
  }) async {
    final url = Uri.parse('$baseUrl/api/comments/comments');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Send the JWT token
        },
        body: jsonEncode({
          'recipe_id': recipeId,
          'comment': comment,
          'rating': rating,
        }),
      );

      if (response.statusCode != 201) {
        print('Error inserting comment: ${response.body}');
      }

      return response.statusCode == 201;
    } catch (e) {
      print('Error inserting comment: $e');
      return false;
    }
  }
  // Get all comments for a specific recipe
  static Future<List<Map<String, dynamic>>> getRecipeComments(String recipeId) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/recipe/$recipeId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['comments']);
      } else {
        print('Failed to fetch comments. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching comments: $e');
      return [];
    }
  }

  // Get average rating for a recipe
  static Future<double> getRecipeAverageRating(String recipeId) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/recipe/$recipeId/average_rating');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['average_rating'].toDouble();
      } else {
        print('Failed to fetch average rating. Status code: ${response.statusCode}');
        return 0.0;
      }
    } catch (e) {
      print('Error fetching average rating: $e');
      return 0.0;
    }
  }

  // Get comment count for a recipe
  static Future<int> getRecipeCommentCount(String recipeId) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/recipe/$recipeId/count');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['comment_count'];
      } else {
        print('Failed to fetch comment count. Status code: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('Error fetching comment count: $e');
      return 0;
    }
  }

  // Update a comment
  static Future<bool> updateComment(Map<String, dynamic> comment) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/${comment['id']}');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(comment),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating comment: $e');
      return false;
    }
  }

  // Delete a comment
  static Future<bool> deleteComment(int id) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting comment: $e');
      return false;
    }
  }

  // Get user's comments
  static Future<List<Map<String, dynamic>>> getUserComments(String userId) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/user/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['comments']);
      } else {
        print('Failed to fetch user comments. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching user comments: $e');
      return [];
    }
  }

  // Check if user has already commented on a recipe
  static Future<bool> hasUserCommented(String userId, String recipeId) async {
    final url = Uri.parse('$baseUrl/api/comments/comments/has_commented?user_id=$userId&recipe_id=$recipeId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['has_commented'];
      } else {
        print('Failed to check if user has commented. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error checking if user has commented: $e');
      return false;
    }
  }
}