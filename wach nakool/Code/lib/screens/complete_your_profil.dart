// import 'package:mobile_project/data/icons.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_project/screens/home.dart';

// class CompleteYourProfil extends StatefulWidget {
//   const CompleteYourProfil({super.key});

//   @override
//   State<CompleteYourProfil> createState() => _CompleteYourProfilState();
// }

// class _CompleteYourProfilState extends State<CompleteYourProfil> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Center(
//         child: Text(
//           "حساب تعريفي",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFFFD5D69),
//           ),
//         ),
//       )),
//       body: Center(
//         child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0), // Add padding for better spacing
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 "أكمل ملفك الشخصي",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 textAlign: TextAlign.right,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "قم بإضافة صورة شخصية (إختياري)",
//                 style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
//                 textAlign: TextAlign.right,
//               ),
//               SizedBox(height: 20),
//               Center(child: Profile2),
//               SizedBox(
//                 height: 250,
//                 width: 100,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                                   Navigator.pushReplacement(
//                   context,
//                       MaterialPageRoute(
//                           builder: (context) => Home())
//                 );
//                   // Add your button logic here
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFFD5D69),
//                   minimumSize: Size(200, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: Text(
//                   "استمر",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       )

//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'package:mobile_project/screens/home.dart';
import 'dart:io';

class CompleteYourProfil extends StatefulWidget {
  const CompleteYourProfil({super.key});

  @override
  State<CompleteYourProfil> createState() => _CompleteYourProfilState();
}

class _CompleteYourProfilState extends State<CompleteYourProfil> {
  XFile? _selectedImage; // To store the selected image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to pick an image
  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage; // Save the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "حساب تعريفي",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFD5D69),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(16.0), // Add padding for better spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "أكمل ملفك الشخصي",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 20),
                const Text(
                  "قم بإضافة صورة شخصية (إختياري)",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 20),
                // Clickable Profile Image
                GestureDetector(
                  onTap: _pickImage, // Pick an image when tapped
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : null,
                    backgroundColor: const Color(0xFFFD5D69),
                    child: _selectedImage == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFD5D69),
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "استمر",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
