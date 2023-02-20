// text to speech service

import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechService {
  // flutter tts instance
  final TextToSpeech tts = TextToSpeech();

  // singelton


  // speak text
  Future speak(String text) async {
    await tts.setLanguage("en-US");
    // speed
    await tts.setRate(0.6);
    await tts.speak(text);
  }

  // test speak
  Future<bool> testSpeak() async {
    await speak("Welcome to Utter app, to know commands say instructions");
    return true;
  }

  // say Welcome to Utter
  Future welcome() async {
    await speak("Welcome to Utter app, to know commands say instructions");
  }

  // say Welcome back to Utter
  Future welcomeBack(String email) async {
    await speak(
        "Welcome back $email to Utter app, to know commands say instructions");
  }

  // 0- hey utter  hey google
  Future helpInstructions() async {
    await speak('''What do you need? 
    0 instructions
1 to signup say
2 login 
3 log out 
4 new message 
5 inbox 
6 sent message 
7 send 
8 read the new message
9 read message title 
10 read message
11 go back  
    ''');
  }

  Future homePageInstructions() async {
    await speak('''You are in home page, the actions you can perform are  
    1 new message.
    2 inbox.
    3 my messages.
    4 sign out.
    to choose one of them touch the screen and say the action
    ''');
  }

  Future newMessagePage() async {
    await speak('''You are in new message page, the actions you can perform are
    1 send
    2 read my message
    3 go back
    to choose one of them touch the screen and say the action
    but to create new message 
    double tap the screen then say the email address
    long press the screen then say the subject
    drag the screen vertical then say the body
    ''');
  }

  Future inboxPage()async{
    await speak('''You are in inbox page, the actions you can perform are
    1 read new message by double tap the screen to go to next
    2 read message title by long press the screen to go to next
    3 go back
    to choose one of them touch the screen and say the action
    ''');
  }

  Future readMessageInstructions() async {
    await speak('''
      to read the new message double tap the screen
    ''');
  }

  Future readTitleInstructions() async {
    await speak('''
      to read the message title long press the screen
    ''');
  }

  Future readMessage(String? toEmail, String? subject, String? body) async {
    await speak('''To email is $toEmail, subject is $subject, body is $body are you sure you want to send this message?. to send it tap the screen and say send''');
  }

  // read specific message by saying the title instruction
  Future readSpeceficMessageInstructions() async {
    await speak('''
      to read specific message by saying the title instruction after vertical drag the screen
    ''');
  }

  // speceficMessageNotFound
  Future speceficMessageNotFound() async {
    await speak('''
       message not found, unfortunately, please try again
    ''');
  }

  Future invalidEmail() async {
    await speak('''Invalid email address, please try again''');
  }

  Future emptyText() async {
    await speak('''Please say something''');
  }

  Future signupLoginPage() async {
    await speak('''You are in sign up page, the actions you can perform are  
    1 sign up
    2 login
    3 read my credentials
    to choose one of them touch the screen and say the action
    to enter your email and password, drag vertical the screen then say email, and drag horizontal then say password
    ''');
  }

  Future sentMessagePageInstructions() async {
    await speak('''You are in my messages page, the actions you can perform are  
    1 read the new message by double tap the screen to go to next
    2 read message title by long press the screen to go to next
    3 go back
    to choose one of them touch the screen and say the action
    ''');
  }

  Future invalidPassword() async {
    await speak('''Invalid password, the password must be at least 6 characters''');
  }

  // sign up failed
  Future signUpFail() async {
    await speak('''Sign up failed, please try again
    ''');
  }

  // sign up success
  Future signUpSuccess() async {
    await speak('''Sign up success, please login
    ''');
  }
}
