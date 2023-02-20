// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:utter/widgets/clipper.dart';

PreferredSize UtterAppBar(String title, double height) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: ClipPath(
      clipper: WaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(224, 64, 251, 1),
              Color.fromRGBO(90, 70, 178, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Your Voice is Your Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget UtterGlowMic() {
    return AvatarGlow(
      endRadius: 70,
      glowColor: Color.fromRGBO(224, 64, 251, 1),
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: CircleAvatar(
        minRadius: 30,
        maxRadius: 40,
        child: Icon(
          Icons.mic,
        ),
      ),
    );
  }
