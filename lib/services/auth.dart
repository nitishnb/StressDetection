import 'package:stress_detection/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_detection/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User1? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return User1(uid: user.uid);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<User1?> get user{
    return _auth.authStateChanges()
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword (String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with uid
      await DatabaseService(uid : user!.uid).updateUserData(name, email, '');
      return _userFromFirebaseUser(user!);
    } catch(e){
      print(e.toString());
      return null;
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

  Future signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult = await _auth.signInWithCredential(credential);
    User? user = authResult.user;

    await DatabaseService(uid : user!.uid).updateUserData(user!.displayName, user!.email, user!.photoURL);
    return _userFromFirebaseUser(user!);
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();
    await signOut();

    print("User Sign Out");
  }

}