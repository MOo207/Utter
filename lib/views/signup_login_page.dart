import 'package:flutter/material.dart';
import 'package:utter/services/auth_service.dart';
import 'package:utter/services/speech_to_text_service.dart';
import 'package:utter/services/text_to_speech.dart';
import 'package:utter/utils/global.dart';
import 'package:utter/views/home_page.dart';
import 'package:utter/widgets/custom_widgets.dart';

class SignupLoginPage extends StatefulWidget {
  const SignupLoginPage({super.key});

  @override
  State<SignupLoginPage> createState() => _SignupLoginPageState();
}

class _SignupLoginPageState extends State<SignupLoginPage> {
  // text to speech instance
  TextToSpeechService tts = TextToSpeechService();

  // auth service instance
  AuthService _auth = AuthService();

  String? email, password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tts.signupLoginPage().then((value) => print("done"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SpeechApi.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // onResult
    void onSignupLoginResult(String text) {
      print(text);
      // if text is new message
      if (text == "sign up") {
        // validate email and password
        if (email != null && password != null) {
          if (email!.contains("@") && email!.contains(".")) {
            if (password!.length > 6) {
              _auth
                  .registerWithEmailAndPassword(email!, password!)
                  .then((value) {
                if (value) {
                  print("-------------------------------");
                  // navigate to home page
                  navKey.currentState!.pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  tts.invalidEmail().then((value) => print("done"));
                }
              });
            } else {
              tts.invalidPassword().then((value) => print("done"));
            }
          } else {
            tts.invalidEmail().then((value) => print("done"));
          }
          print("-------------------------------");
          // sign up
          // navigate to home page
        } else {
          tts.emptyText().then((value) => print("done"));
        }
      } else if (text == "login") {
        // validate email and password
        if (email != null && password != null) {
          if (email!.contains("@") && email!.contains(".")) {
            if (password!.length > 6) {
              _auth.loginWithEmailAndPassword(email!, password!).then((value) {
                if (value) {
                  print("-------------------------------");
                  // navigate to home page
                  navKey.currentState!.pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  tts.invalidEmail().then((value) => print("done"));
                }
              });
            } else {
              tts.invalidPassword().then((value) => print("done"));
            }
          } else {
            tts.invalidEmail().then((value) => print("done"));
          }
          print("-------------------------------");
          // sign up
          // navigate to home page
        }
      } else if (text == "read my credentials") {
        // handle if one of the fields is empty
        if (email != null && password != null) {
          tts
              .speak("your entered email is $email and password is $password")
              .then((value) => print("done"));
        } else {
          tts.emptyText().then((value) => print("done"));
        }
      } else {
        tts.emptyText().then((value) => print("done"));
      }
    }

    void onToEmailResult(String text) {
      print(text);
      // if text is new message
      // validate its an email
      if (text.contains("@") && text.contains(".")) {
        print("-------------------------------");
        setState(() {
          email = text;
        });
      } else {
        tts.invalidEmail().then((value) => print("done"));
      }
    }

    void onPasswordResult(String text) {
      print(text);
      // if text is new message
      // validate its an email
      if (text.length > 6) {
        print("-------------------------------");
        setState(() {
          password = text;
        });
      } else {
        tts.invalidPassword().then((value) => print("done"));
      }
    }

    // onListening
    void onListening(bool listening) {
      print(listening);
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => SpeechApi.toggleRecording(
          onResult: onSignupLoginResult, onListening: onListening),
      onVerticalDragStart: (details) => SpeechApi.toggleRecording(
          onResult: onToEmailResult, onListening: onListening),
      onHorizontalDragStart: (details) => SpeechApi.toggleRecording(
          onResult: onPasswordResult, onListening: onListening),
      child: Scaffold(
        appBar: UtterAppBar("Signup/Login", height * 0.2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Signup/Login Form",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width * 0.8,
                child: TextField(
                  controller: TextEditingController(text: email),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width * 0.8,
                child: TextField(
                  controller: TextEditingController(text: password),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Image.asset(
                'assets/signup_login_icon.jpeg',
                height: height * 0.3,
                width: width * 0.7,
              ),
              //  animation effect when user talks
              UtterGlowMic(),
            ],
          ),
        ),
      ),
    );
  }
}
