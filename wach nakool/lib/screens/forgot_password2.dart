import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_project/data/icons.dart';
import 'forgot_password3.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({super.key});

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {
  final List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());
  Timer? _timer;
  int _remainingTime = 90;
  @override
  
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCode = prefs.getString('verification_code');
    final enteredCode = controllers.map((c) => c.text).join();
    
    if (storedCode == enteredCode) {
      Get.to(() => const ForgotPassword3());
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('خطأ'),
          content: Text('رمز التحقق غير صحيح'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('موافق'),
            ),
          ],
        ),
      );
    }
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
                  SizedBox(height: 20),
                  Text(
                    "وصلك بريد",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "سوف نرسل لك رمز التحقق إلى عنوان بريدك الإلكتروني، تحقق من بريدك الإلكتروني ثم ضع الرمز أسفله مباشرة.",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: controllers[index],
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
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                                if (value.isNotEmpty && index == 5) {
                                  _verifyCode();
                                }
                              },
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "لم تستلم البريد؟",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    "يمكنك إعادة إرساله خلال $_remainingTime ثانية",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 220,
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: _verifyCode,
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
}
