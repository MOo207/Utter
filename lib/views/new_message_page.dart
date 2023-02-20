import 'package:flutter/material.dart';
import 'package:utter/models/email.dart';
import 'package:utter/services/auth_service.dart';
import 'package:utter/services/firestore_service.dart';
import 'package:utter/services/speech_to_text_service.dart';
import 'package:utter/services/text_to_speech.dart';
import 'package:utter/utils/global.dart';
import 'package:utter/utils/utils.dart';
import 'package:utter/views/home_page.dart';
import 'package:utter/widgets/custom_widgets.dart';

class NewMessagePage extends StatefulWidget {
  NewMessagePage({super.key});

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  // auth service instance
  final AuthService _auth = AuthService();
  // firestore service instance
  final FirestoreService _firestore = FirestoreService();
  // test to speech instance
  final TextToSpeechService tts = TextToSpeechService();

  String? toEmail;
  String? subject;
  String? body;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tts.newMessagePage().then((value) => print("done"));
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
    void onNewMessageResult(String text) {
      print(text);
      // if text is new message
      if (text == "send") {
        // check if all fields are filled
        if (toEmail != null && subject != null && body != null) {
          // create email object
          Email email = Email(
            date: DateTime.now().toString(),
            fromEmail: _auth.currentUser().toString(),
            toEmail: toEmail.toString(),
            subject: subject.toString(),
            message: body.toString(),
          );
          _firestore.addEmail(email).then((value) {
            if (value) {
              tts.speak("Email sent successfully").then((value) => print("done"));
            } else {
              tts.speak("Email sent fail").then((value) => print("done"));
            } 
          });
          // sendEmail(
          //   to_email: toEmail.toString(),
          //   from_email: _auth.currentUser().toString(),
          //   subject: subject.toString(),
          //   message: body.toString(),
          // );
        } else {
          tts.emptyText().then((value) => print("done"));
        }
      } else if (text == "go back") {
        navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (text == "read my message"){
        tts.readMessage(toEmail, subject, body).then((value) => print("done"));
      }
    }

    void onToEmailResult(String text) {
      print(text);
      // if text is new message
      // validate its an email
      if (text.contains("@") && text.contains(".")) {
        print("-------------------------------");
        setState(() {
          toEmail = text;
        });
      } else {
        tts.invalidEmail().then((value) => print("done"));
      }
    }

    void onSubjectResult(String text) {
      print(text);
      // if text is new message
      if (text.isNotEmpty) {
        print("-------------------------------");
        setState(() {
          subject = text;
        });
      } else {
        tts.emptyText().then((value) => print("done"));
      }
    }

    void onBodyResult(String text) {
      print(text);
      // if text is new message
      // validate its an email
      if (text.isNotEmpty) {
        print("-------------------------------");
        setState(() {
          body = text;
        });
      } else {
        tts.emptyText().then((value) => print("done"));
      }
    }

    // onListening
    void onListening(bool listening) {
      print(listening);
    }
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
    // show form of email filled by parameters data
    return GestureDetector(
      onTap: () => SpeechApi.toggleRecording(
        onResult: onNewMessageResult,
        onListening: onListening,
      ),
      onDoubleTap: () => SpeechApi.toggleRecording(
        onResult: onToEmailResult,
        onListening: onListening,
      ),
      onLongPress: () => SpeechApi.toggleRecording(
        onResult: onSubjectResult,
        onListening: onListening,
      ),
      onVerticalDragStart: (details) => SpeechApi.toggleRecording(
        onResult: onBodyResult,
        onListening: onListening,
      ),
      child: Scaffold(
        appBar: UtterAppBar("New Message",height*0.2),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // textfeilds with labels
                TextField(
                  enabled: false,
                  // content of textfeild
                  controller: TextEditingController(text: toEmail),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'To',
                  ),
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  enabled: false,
                  maxLines: 1,
                  // content of textfeild
                  controller: TextEditingController(text: subject),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subject',
                  ),
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  enabled: false,
                  maxLines: 4,
                  // content of textfeild
                  controller: TextEditingController(text: body),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Body',
                  ),
                ),
                SizedBox(height: height * 0.02),
                Image.asset(
                      'assets/send_message_icon.jpeg',
                      height: height * 0.2,
                      width: width * 0.7,
                    ),
                    //  animation effect when user talks
                    UtterGlowMic(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
