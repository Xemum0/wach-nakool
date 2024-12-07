import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/screens/complete_your_profil.dart';
import 'package:mobile_project/screens/login.dart';
import '../data/user_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // Form Key for Validation
  final _formKey = GlobalKey<FormState>();

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Center(
              child: Icon(Icons.check_circle, color: Colors.green, size: 50)),
          content: const Column(
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
                'مرحباً بك في واجهة التطبيق. سيتم إعادة توجيهك لاستكمال ملفك الشخصي.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                var email = _emailController.text;
                var name = email.split('@')[0];
                userController.setUsername(name);
                Get.off(
                    () => const CompleteYourProfil()); // Pass username to next screen
              },
              child: const Text('موافق'),
            ),
          ],
        );
      },
    );
  }

  // Form validation logic
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة السر مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة السر يجب أن تكون 6 خانات على الأقل';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة السر مطلوب';
    }
    if (value != _passwordController.text) {
      return 'كلمة السر غير متطابقة';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.black), // Updated back icon
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
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
            child: Form(
              key: _formKey, // Form Key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _buildTextField("الاسم الكامل", "John Doe", false,
                      controller:
                          _usernameController), // Use the username controller
                  const SizedBox(height: 10),
                  _buildTextField(
                      "البريد الإلكتروني", "example@example.com", false,
                      controller: _emailController, validator: _validateEmail),
                  const SizedBox(height: 10),
                  _buildTextField(
                      "رقم الهاتف (اختياري)", "+ 123 456 789", false),
                  const SizedBox(height: 10),
                  _buildTextField("تاريخ الميلاد", "DD / MM / YYYY", false),
                  const SizedBox(height: 10),
                  _buildTextField("كلمة السر", "●●●●●●●", true,
                      controller: _passwordController,
                      validator: _validatePassword),
                  const SizedBox(height: 10),
                  _buildTextField("تأكيد كلمة السر", "●●●●●●●", true,
                      controller: _confirmPasswordController,
                      validator: _validateConfirmPassword),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _showSuccessDialog(
                            context); // Show success dialog if valid
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD5D69),
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "دخول",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: ' من خلال الاستمرار، فإنك توافق على',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'شروط الاستخدام',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: ' و ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'سياسة الخصوصية',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => (const Login()));
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: " لديك حساب؟",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: " سجل الدخول",
                            style: TextStyle(color: Color(0xFFFD5D69)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hintText,
    bool pass, {
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFC6C9).withOpacity(0.45),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: pass && !_isPasswordVisible,
            textAlign: TextAlign.right,
            validator: validator, // Pass validator for form validation
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
  }
}
