import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class EmailService {
  static final _random = Random();

  // Generate a 6-digit verification code
  static String generateVerificationCode() {
    return (_random.nextInt(900000) + 100000).toString();
  }

  Future<bool> sendVerificationCode(String email,String verificationCode) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': 'service_12vwjdl',
          'template_id': 'template_dm0v9vc',
          'user_id': 'OMXQa9raBZ2NSiZBa',
          'template_params': {
            'user_email': email,
            'code': verificationCode,
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Verification code sent successfully to $email');
        return true; // Email sent successfully
      } else {
        print('Failed to send verification code. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false; // Email sending failed
      }
    } catch (e) {
      print('Error sending verification code: $e');
      return false; // Email sending failed due to an exception
    }
  }
}