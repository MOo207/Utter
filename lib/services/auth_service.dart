// firebase auth service class

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> authStateChanges() => _auth.authStateChanges();

// get current user
  String? currentUser() {
    try {
      return _auth.currentUser!.email;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // register with email and password
  

  // login with email and password
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signOut(){
    try{
      _auth.signOut();
      return Future.value(true);
    }catch(e){
      print(e.toString());
      return Future.value(false);
    }
  }

}