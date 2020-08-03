import 'package:brew_crew/Screens/Authentication/sign_in.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              setState(() {
                loading=false;
              });
              await _auth.signout();
            },
            label: Text("Logout"),
          ),
        ],
      ),
      body: Container(
        child: Center(child: Text("Home Screen")),
      ),
    );
  }
}
