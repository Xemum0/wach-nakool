import 'package:flutter/material.dart';

class AppStyles {
  // Drawer Header Style
  static const TextStyle drawerHeaderTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // Profile Name Style
  static const TextStyle profileNameStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  // Profile Description Style
  static const TextStyle profileDescriptionStyle = TextStyle(
    fontSize: 14,
    color: Colors.black54,
    height: 1.4,
  );

  // Profile Username Style
  static const TextStyle profileUsernameStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
  );

  // Text Button Style
  static const TextStyle textButton = TextStyle(
    fontSize: 14,
    color: Color(0xFFF7646D),
    fontWeight: FontWeight.w600,
  );

  // Edit Profile Button Style
  static ButtonStyle editProfileButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFC6C9),
    foregroundColor: const Color(0xFFF7646D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    elevation: 3,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
  );
 static ButtonStyle saveButton = ElevatedButton.styleFrom(
    minimumSize: const Size(200, 48),
    backgroundColor: const Color(0xFFFFC6C9),
    foregroundColor: const Color(0xFFF7646D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    elevation: 3,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
  );
  static ButtonStyle formstyle = ElevatedButton.styleFrom(
    backgroundColor:const Color.fromARGB(255, 251, 116, 123),
    foregroundColor: const Color.fromARGB(255, 251, 116, 123),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    elevation: 3,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
  );
  // Favorite Empty Text Style
  static const TextStyle favoriteEmptyTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.grey,
    fontWeight: FontWeight.w300,
  );

  // Grid Item Title Style
  static const TextStyle gridItemTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const TextStyle appBarstyle = TextStyle(
            fontSize: 18.0,
            color: Color(0xFFF7646D),
            fontWeight: FontWeight.w500,  
  );

  // Grid Item Duration Style
  static const TextStyle gridItemDurationStyle = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  // Grid Item Rating Style
  static const TextStyle gridItemRatingStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  // Menu Button Style
  static const menuButtonStyle = ButtonStyle(
    iconColor: WidgetStatePropertyAll(Color(0xFFF7646D)),
    backgroundColor: WidgetStatePropertyAll(Color(0xFFFFC6C9)),
    iconSize: WidgetStatePropertyAll(20),
  );
}