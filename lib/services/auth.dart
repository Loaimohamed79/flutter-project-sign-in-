import 'package:brew_crew/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebaseruser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uId: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signinanon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//sign up with facebook
Future signUpWithFacebook() async{
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        return user;
      }
    }catch (e) {
      print(e.message);
    }
  }
  // sign in with with apple 
}
