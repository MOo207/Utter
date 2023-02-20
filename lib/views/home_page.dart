import 'package:flutter/material.dart';
import 'package:utter/services/auth_service.dart';
import 'package:utter/services/firestore_service.dart';
import 'package:utter/services/speech_to_text_service.dart';
import 'package:utter/services/text_to_speech.dart';
import 'package:utter/utils/global.dart';
import 'package:utter/views/inbox_page.dart';
import 'package:utter/views/new_message_page.dart';
import 'package:utter/views/sent_message_page.dart';
import 'package:utter/views/signup_login_page.dart';
import 'package:utter/widgets/custom_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // auth service instance
  final AuthService _auth = AuthService();
// firestore service instance
  final FirestoreService _firestore = FirestoreService();
  // text to speech instance
  final TextToSpeechService tts = TextToSpeechService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tts.homePageInstructions().then((value) => print("done"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SpeechApi.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // onResult
    void onHomeResult(String text) {
      String userEmail = _auth.currentUser().toString();
      print(text);
      // if text is new message
      if (text == "new message") {
        print("-------------------------------");
        // navigate to send email page
        navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => NewMessagePage()),
        );
      } else if (text == "inbox") {
        navKey.currentState!.pushReplacement(
          MaterialPageRoute(
              builder: (context) => InboxPage(
                    userEmail: userEmail,
                  )),
        );
      } else if (text == "my messages") {
        navKey.currentState!.pushReplacement(
          MaterialPageRoute(
              builder: (context) => SentMessagePage(
                    userEmail: userEmail,
                  )),
        );
      } else if (text == "sign out") {
        print("-------------------------------");
        // sign out
        _auth.signOut();
        // navigate to signup login page
        navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => SignupLoginPage()),
        );
      }
    }

    // onListening
    void onListening(bool listening) {
      print(listening);
    }
    return GestureDetector(
      onTap: () => SpeechApi.toggleRecording(
          onResult: onHomeResult, onListening: onListening),
      child: Scaffold(
        appBar: UtterAppBar("Utter", height*0.2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/home_icon.jpeg',
                height: height * 0.4,
                width: width * 0.8,
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