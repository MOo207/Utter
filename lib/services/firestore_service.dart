import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utter/models/email.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  FirestoreService._internal();

// firebase firestore instance

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// add email, subject and message to firestore

  Future<bool> addEmail(Email email) async {
    try {
      await _firestore.collection('emails').add(email.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

// get inbox messages distinct by subject
  Future<List<Email>> getInbox(String email) {
    // get inbox messages distinct by subject
    return _firestore
        .collection('emails')
        .where('to_email', isEqualTo: email)
        .get()
        .then((value) {
      List<Email> emails = [];
      value.docs.forEach((element) {
        emails.add(Email.fromJson(element.data()));
      });
      // compare every email with the next email based on subject
      for (int i = 0; i < emails.length; i++) {
        for (int j = i + 1; j < emails.length; j++) {
          if (emails[i].subject == emails[j].subject) {
            // if the subject is the same, remove the email
            emails.removeAt(j);
          }
        }
      }
      return emails;
    }); 
  }

// get inbox messages distinct by subject
  Future<List<Email>> getSentMessage(String email) {
    // get inbox messages distinct by subject
    return _firestore
        .collection('emails')
        .where('from_email', isEqualTo: email)
        .get()
        .then((value) {
      List<Email> emails = [];
      value.docs.forEach((element) {
        emails.add(Email.fromJson(element.data()));
      });
      // compare every email with the next email based on subject
      for (int i = 0; i < emails.length; i++) {
        for (int j = i + 1; j < emails.length; j++) {
          if (emails[i].subject == emails[j].subject) {
            // if the subject is the same, remove the email
            emails.removeAt(j);
          }
        }
      }
      return emails;
    });
  }

}
