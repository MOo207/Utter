import 'package:flutter/material.dart';
import 'package:utter/models/email.dart';
import 'package:utter/services/firestore_service.dart';
import 'package:utter/services/speech_to_text_service.dart';

import 'package:utter/services/text_to_speech.dart';
import 'package:utter/utils/global.dart';
import 'package:utter/views/home_page.dart';
import 'package:utter/widgets/custom_widgets.dart';

class SentMessagePage extends StatefulWidget {
  SentMessagePage({super.key, this.userEmail});
  final String? userEmail;

  @override
  State<SentMessagePage> createState() => _SentMessagePageState();
}

class _SentMessagePageState extends State<SentMessagePage> {
// firestore service instance
  final FirestoreService _firestore = FirestoreService();
  // text to speech instance
  final TextToSpeechService tts = TextToSpeechService();
  // speech to text instance

  Future? getSentMessage;
  List<Email> emails = [];
  int emailIndex = 0;
  int titleIndex = 0;
  @override
  void initState() {
    super.initState();
    tts.sentMessagePageInstructions().then((value) => print("done"));
    getSentMessage = _firestore.getSentMessage(widget.userEmail!);
  }

  @override
  Widget build(BuildContext context) {
    void onInboxResult(String result) {
      if (result == "read new messages") {
        tts.readMessageInstructions().then((value) => print("done"));
      } else if (result == "read message title") {
        tts.readTitleInstructions().then((value) => print("done"));
      } else if (result == "go back") {
        navKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
    }

    Future<void> onReadMessage() async {
      await readEmail(emails[emailIndex]);
      // handle the case when there are no more messages
      if (emailIndex == emails.length - 1) {
        emailIndex = 0;
      } else {
        emailIndex++;
      }
    }

    Future<void> onReadTitle() async {
      await readTitle(emails[titleIndex]);
      // handle the case when there are no more messages
      if (titleIndex == emails.length - 1) {
        titleIndex = 0;
      } else {
        titleIndex++;
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
            onResult: onInboxResult, onListening: onListening),
        onDoubleTap: () => onReadMessage(),
        onLongPress: () => onReadTitle(),
        child: Scaffold(
          appBar: UtterAppBar("My Messages", height*0.2),
          body: FutureBuilder(
            future: getSentMessage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  emails.add(snapshot.data[i]);
                }
                return Column(
                  children: [
                    Container(
                      height: height * 0.2,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].message),
                            );
                          }),
                    ),
                    Image.asset(
                      'assets/send_message_icon.jpeg',
                      height: height * 0.3,
                      width: width * 0.7,
                    ),
                    //  animation effect when user talks
                    UtterGlowMic(),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  // future to speak all emails
  Future<void> readEmail(Email email) async {
    await tts.speak("The sender is: " +
        email.fromEmail +
        " The subject is: " +
        email.subject +
        "  The message is: " +
        email.message);
  }

  // read title of email
  Future<void> readTitle(Email email) async {
    await tts.speak("The subject is: " + email.subject);
  }
}
