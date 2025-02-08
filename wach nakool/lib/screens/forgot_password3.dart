import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'package:mobile_project/screens/home/home_skeleton.dart';
import 'package:mobile_project/supabase/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword3 extends StatefulWidget {
  const ForgotPassword3({super.key});

  @override
  State<ForgotPassword3> createState() => _ForgotPassword3State();
}

class _ForgotPassword3State extends State<ForgotPassword3> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final bool _isChecked = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible =
      false; // Added state for confirm password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: BackArrow,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          ' انشاء كلمة السر الجديدة',
          style:
              TextStyle(color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "إنشاء كلمة مرور جديدة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 20),
                Text(
                  "أدخل كلمة المرور الجديدة، وإذا نسيتها، فعليك اتباع خطوة نسيان كلمة المرور.",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 20),
                _buildTextField("كلمة السر", "●●●●●●●", true),
                SizedBox(height: 10),
                _buildTextField("تأكيد كلمة السر", "●●●●●●●", false),
                SizedBox(height: 10),
                SizedBox(height: 200, width: 100),
                ElevatedButton(
                  onPressed: () {
                    if (_passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      _showErrorDialog(
                          context, "الرجاء إدخال كلمة المرور وتأكيدها.");
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      _showErrorDialog(
                          context, "كلمة المرور وتأكيدها غير متطابقتين.");
                    } else {
                      _changePassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD5D69),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
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

  Future<void> _changePassword() async {
    final newPassword = _passwordController.text;
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('verification_email');

    if (email == null) {
      _showErrorDialog(context, "حدث خطأ. الرجاء المحاولة مرة أخرى.");
      return;
    }

    // Call the database function to update the password
    final success = await UserHelper.updatePassword(email, newPassword);
    await UserHelper.authenticateUser(email, newPassword);
    await prefs.setString('email', email);
    if (success) {
      _showSuccessDialog(context);
    } else {
      _showErrorDialog(context, "فشل تغيير كلمة المرور. حاول مرة أخرى.");
    }
  }

  Widget _buildTextField(String label, String hintText, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFC6C9).withOpacity(0.45),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            controller:
                isPassword ? _passwordController : _confirmPasswordController,
            obscureText: isPassword
                ? !_isPasswordVisible
                : !_isConfirmPasswordVisible, // Handle visibility based on the field
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              suffixIcon: IconButton(
                icon: Icon(
                  (isPassword ? _isPasswordVisible : _isConfirmPasswordVisible)
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    if (isPassword) {
                      _isPasswordVisible = !_isPasswordVisible;
                    } else {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("خطأ"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("حسنا"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Icon(
              Icons.check, // Checkmark icon
              color: Color(0xFFFD5D69), // Set the color to red
              size: 50, // Icon size
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تم التسجيل بنجاح!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "مرحبا بك في واش ناكل سيُعاد توجيهك لإكمال ملفك الشخصي.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                
                Navigator.pop(context); // Close the dialog
                Get.off(() => (const Home()));
              },
              child: Text('العودة الى الرئيسية'),
            ),
          ],
        );
      },
    );
  }
}
