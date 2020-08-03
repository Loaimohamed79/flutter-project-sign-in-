import 'package:brew_crew/Screens/Authentication/register.dart';
import 'package:brew_crew/Screens/Authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
      bool showSignIn = true;
    void toggleVeiws() {
      setState(() => showSignIn = !showSignIn);
    }
  @override
  Widget build(BuildContext context) {


    if (showSignIn) {
      return SignIn(toggleVeiw: toggleVeiws);
    } else {
      return Register(toggleVeiw: toggleVeiws);
    }
  }
}
