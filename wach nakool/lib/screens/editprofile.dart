import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_project/screens/profile.dart';
import 'package:mobile_project/styles/style.dart';
import 'package:mobile_project/supabase/user.dart';

class EditProfile extends StatefulWidget {
  final String imagePath;
  final String username;
  final String bio;
  final String fullName;
  final String userID;
  EditProfile(
      {super.key,
      required this.imagePath,
      required this.username,
      required this.bio,
      required this.fullName,
      required this.userID});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _imagePath;
  String? _imageBase64;
  late final TextEditingController _fullNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _usernameController = TextEditingController(text: widget.username);
    _bioController = TextEditingController(text: widget.bio);
    _imagePath = widget.imagePath;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        _imagePath = pickedFile.path;
        _imageBase64 = base64Image;
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
            'assets/icons/arrow_back.svg', // Path to your SVG file
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
                          ? (_imagePath!.startsWith('http')
                              ? NetworkImage(_imagePath!) as ImageProvider
                              : FileImage(File(_imagePath!)))
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
                  onPressed: () async {
                    // Call the updateUser function directly
                    await updateUser(
                      id: widget.userID,
                      username: _usernameController.text,
                      fullName: _fullNameController.text,
                      bio: _bioController.text,
                      profileImgBase64: _imageBase64 ?? widget.imagePath,
                    );

                    // Navigate back to the profile screen
                    Get.off(ProfileScreen());
                  },
                  style: AppStyles.saveButton,
                  child: const Text('حفظ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
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
            fillColor: Color(0xFFFFC6C9), // Background color
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
