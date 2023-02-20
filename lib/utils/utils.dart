import 'package:http/http.dart' as http;
import 'dart:convert';

  Future<bool> sendEmail(
      {String? from_email,
      String? to_email,
      String? subject,
      String? message}) async {
    var data = {
      "service_id": 'service_bgaopja',
      "template_id": 'template_a61awf2',
      "user_id": 'Z--l1eYPCHXcVpFkM',
      "template_params": {
        "from_email": from_email,
        "to_email": to_email,
        "subject": subject,
        "message": message,
      }
    };
    var response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: <String, String>{
        'origin': 'https://localhost',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('Email sent.');
      return true;
    } else {
      print(response.body);
      print('Failed to send email.');
      return false;
    }
  }