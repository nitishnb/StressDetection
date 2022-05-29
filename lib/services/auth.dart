import 'dart:async';

import 'package:stress_detection/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_detection/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserId _userFromFirebaseUser(User? user) {

    // ignore: unnecessary_null_comparison
    return user != null ? UserId(uid: user.uid) : UserId(uid: '1');
  }

  //auth change user stream
  Stream<UserId> get userId{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword (String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // register with email and password
  Future registerWithEmailAndPassword (String name, String email, String password) async {
    // try {
    //   UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    //   User? user = result.user;
    //
    //   // create a new document for the user with uid
    //   await DatabaseService(uid : user!.uid).updateUserData(name, email, '');
    //   return _userFromFirebaseUser(user!);
    // } catch(e){
    //   print(e.toString());
    //   return null;
    // }
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      await DatabaseService(uid : user!.uid).updateUserData(name, email, '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // reset password
  Future sendPasswordResetEmail(String email) async {
    try{
      return _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Future signInWithGoogle() async {
  //   GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount!.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   UserCredential authResult = await _auth.signInWithCredential(credential);
  //   User? user = authResult.user;
  //
  //   await DatabaseService(uid : user!.uid).updateUserData(user!.displayName, user!.email, user!.photoURL);
  //   return _userFromFirebaseUser(user!);
  // }

  void signOutGoogle() async{
    await googleSignIn.signOut();
    await signOut();

    print("User Sign Out");
  }

}