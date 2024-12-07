import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_project/screens/profile.dart';
import 'dart:io';

import 'package:mobile_project/styles/style.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _imagePath;
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('تعديل الملف الشخصي', style: AppStyles.appBarstyle),
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/arrow_back.svg',  // Path to your SVG file
              width: 16.0,
              height: 16.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Picture
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imagePath != null
                            ? Image.file(File(_imagePath!)).image
                            : const AssetImage('assets/img/defaultprofile.png'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _pickImage,
                        child: const Text(
                          'تعديل صورة',
                          style: AppStyles.textButton,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Form Fields
                  _buildInputField('الاسم الكامل', _fullNameController),
                  const SizedBox(height: 16),
                  _buildInputField('اسم المستخدم', _usernameController),
                  const SizedBox(height: 16),
                  _buildInputField('عرض تقديمي', _bioController),
                  const SizedBox(height: 32),
                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle save action here

                     Get.off(const ProfileScreen()); //and go back
                    },
                    style: AppStyles.saveButton,
                    child: const Text('حفظ', style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
Widget _buildInputField(String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        label == "عرض تقديمي" ? "عرض تقديمي" : label,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        maxLines: null, // Makes the field resizable like a textarea
        minLines: 1, // Minimum height, can expand beyond this
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFC6C9), // Background color
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0), // Rounded corners
            borderSide: BorderSide.none, // Remove border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide.none, // Remove border color when focused
          ),
        ),
      ),
    ],
  );
}
}