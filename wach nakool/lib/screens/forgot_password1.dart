import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'forgot_password2.dart';
import 'package:mobile_project/supabase/user.dart';
import 'package:mobile_project/services/email_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword1 extends StatefulWidget {
  const ForgotPassword1({super.key});

  @override
  State<ForgotPassword1> createState() => _ForgotPassword1State();
}

class _ForgotPassword1State extends State<ForgotPassword1> {
  final TextEditingController _emailController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _handleContinue() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showError("الرجاء إدخال البريد الإلكتروني");
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Check if email exists in database
      final users = await UserHelper.getAllUsers();
      final userExists = users.any((user) => user['email'] == email);

      if (!userExists) {
        Navigator.pop(context); // Close loading
        _showError("البريد الإلكتروني غير مسجل");
        return;
      }

      // Generate verification code
      final verificationCode = EmailService.generateVerificationCode();
      print("Code is $verificationCode");
      // Save verification code for later validation
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('verification_code', verificationCode);
      await prefs.setString('verification_email', email);
      await prefs.setInt(
          'verification_timestamp', DateTime.now().millisecondsSinceEpoch);

      // Send verification code
      final emailService = EmailService();
      bool emailSent =
          await emailService.sendVerificationCode(email,verificationCode);

      Navigator.pop(context); // Close loading

      if (emailSent) {
        Get.to(() => const ForgotPassword2());
      } else {
        _showError("حدث خطأ أثناء إرسال رمز التحقق");
      }
    } catch (e) {
      Navigator.pop(context); // Close loading
      _showError("حدث خطأ. الرجاء المحاولة مرة أخرى: ${e.toString()}");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('موافق'),
          ),
        ],
      ),
    );
  }

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
            ' نسيت كلمة السر',
            style: TextStyle(
                color: Color(0xFFFD5D69), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding for better spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "!أهلاً بك!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "أدخل عنوان بريدك الإلكتروني. سوف نرسل لك رمز التحقق في الخطوة التالية.",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                      "البريد الإلكتروني", "example@example.com", false,
                      controller: _emailController),
                  SizedBox(
                    height: 250,
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: _handleContinue,
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
        ));
  }

  Widget _buildTextField(String label, String hintText, bool pass,
      {TextEditingController? controller}) {
    if (pass) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                  controller: controller,
                  obscureText: !_isPasswordVisible,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    suffixIcon: pass
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
        },
      );
    } else {
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
              controller: controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      );
    }
  }
}
