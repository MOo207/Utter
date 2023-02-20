// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utter/utils/utils.dart';

void main() async{
//  unit test for third party api email js
  test('Text EMAIL JS third party api', () async {
    bool result = await sendEmail(from_email: "ms@gmail.com", to_email: "m@gmail.com", subject: "TEST", message: "This is message");
    expect(result, true);
  });
}
