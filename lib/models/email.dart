// To parse this JSON data, do
//
//     final email = emailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Email emailFromJson(String str) => Email.fromJson(json.decode(str));

String emailToJson(Email data) => json.encode(data.toJson());

class Email {
    Email({
        required this.fromEmail,
        required this.toEmail,
        required this.subject,
        required this.message,
        required this.date,
    });

    final String fromEmail;
    final String toEmail;
    final String subject;
    final String message;
    final String date;

    factory Email.fromJson(Map<String, dynamic> json) => Email(
        fromEmail: json["from_email"],
        toEmail: json["to_email"],
        subject: json["subject"],
        message: json["message"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "from_email": fromEmail,
        "to_email": toEmail,
        "subject": subject,
        "message": message,
        "date": date,
    };
}
