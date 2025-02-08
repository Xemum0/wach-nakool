import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/signup.dart';
import 'package:mobile_project/screens/forgot_password1.dart';
import 'package:mobile_project/screens/home/home_skeleton.dart';
import 'package:mobile_project/supabase/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("الرجاء ملء جميع الحقول");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Try to authenticate user using the database
      final user = await UserHelper.authenticateUser(email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      
      Navigator.pop(context); // Close loading dialog

      if (user != null) {
        Get.off(() => const Home());
      } else {
        _showError("البريد الإلكتروني أو كلمة السر غير صحيحة");
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      _showError("حدث خطأ أثناء تسجيل الدخول. الرجاء المحاولة مرة أخرى.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: BackArrow,
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Text(
          'تسجيل الدخول',
          style: TextStyle(
            color: Color(0xFFFD5D69),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                _buildTextField(
                    "البريد الإلكتروني", "example@example.com", false),
                SizedBox(height: 10),
                _buildTextField("كلمة السر", "●●●●●●●", true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD5D69),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "دخول",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => (RegistrationPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD5D69),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => (const ForgotPassword1()));
                  },
                  child: Text(
                    "نسيت كلمة السر؟",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => (const Home()));
                  },
                  child: Text(
                    "تخطي انشاء الحساب",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hintText, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFC6C9).withOpacity(0.45),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            controller: isPassword ? _passwordController : _emailController,
            obscureText: isPassword && !_isPasswordVisible,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
