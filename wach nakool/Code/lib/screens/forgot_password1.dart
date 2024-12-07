import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'forgot_password2.dart';

class ForgotPassword1 extends StatefulWidget {
  const ForgotPassword1({super.key});

  @override
  State<ForgotPassword1> createState() => _ForgotPassword1State();
}

class _ForgotPassword1State extends State<ForgotPassword1> {
  @override
  bool _isPasswordVisible = false;
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
          title: const Text(
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
                  const SizedBox(height: 20),
                  const Text(
                    "!أهلاً بك!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "أدخل عنوان بريدك الإلكتروني. سوف نرسل لك رمز التحقق في الخطوة التالية.",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "البريد الإلكتروني", "example@example.com", false),
                  const SizedBox(
                    height: 250,
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
      Get.to(()=> (const ForgotPassword2()));
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
        ));
  }

  Widget _buildTextField(String label, String hintText, bool pass) {
    if (pass) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                child: TextField(
                  obscureText: !_isPasswordVisible,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      );
    }
  }
}
