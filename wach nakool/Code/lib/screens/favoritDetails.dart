import 'package:mobile_project/screens/utilitis.dart';
import 'package:flutter/material.dart';
class FavoriteGroupScreen extends StatelessWidget {
  final String groupName;
  final List<Map<String, String>> recipes;

  const FavoriteGroupScreen({
    required this.groupName,
    required this.recipes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('وصفات $groupName'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Suggestions(
            recipe['image']!,
            recipe['text']!,
            recipe['description']!,
            recipe['stars']!,
            recipe['time']!,
          );
        },
      ),
    );
  }
}