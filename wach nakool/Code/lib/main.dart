import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/screens/WElcome.dart';
import 'data/user_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const Welcome(),
        initialBinding: BindingsBuilder(() {
        Get.put(UserController()); // Initializing the controller here
      }),
        
        );
  }
}
