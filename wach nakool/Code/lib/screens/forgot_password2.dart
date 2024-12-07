import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'forgot_password3.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({super.key});

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {
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
            ' نسيت كلمةالسر',
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
                    "وصلك بريد",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "سوف نرسل لك رمز التحقق إلى عنوان بريدك الإلكتروني، تحقق من بريدك الإلكتروني ثم ضع الرمز أسفله مباشرة.",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1, // Restrict to one digit
                          decoration: InputDecoration(
                            counterText: '', // Remove the character counter
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  const BorderSide(color: Color(0xFFFD5D69)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  const BorderSide(color: Color(0xFFFD5D69)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context)
                                  .nextFocus(); // Move to the next field
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context)
                                  .previousFocus(); // Move to the previous field
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "لم تستلم البريد؟",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  const Text(
                    "يمكنك إعادة إرساله خلال 49 ثانية",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 220,
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
      Get.to(()=> (const ForgotPassword3()));
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
}
