import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shape/loading.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignIn extends StatefulWidget {
  final Function toggleVeiw;
  SignIn({this.toggleVeiw});

  @override
  _SignInState createState() => _SignInState();
}

final _formKey = GlobalKey<FormState>();
final AuthServices _auth = AuthServices();
// final FirebaseAuth _auth1 = FirebaseAuth.instance;
final facebookLogin = FacebookLogin();

bool loading = false;
String email = '';
String password = '';
String error = '';

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              title: Text("Sign in to brew crew"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                  onPressed: () {
                    print("pressed");
                    widget.toggleVeiw();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter your email'.padRight(15),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) => val.length < 8
                            ? 'Enter your password 8 char at least,pls'
                            : null,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Colors.black,
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'COULD NOT SIGN IN WHITH THOSE CEDENTIALS'
                                        .toLowerCase();
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Text(
                          error,
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.black,
                        child: Text(
                          "Sign in With Facebook",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () async {
                          AuthServices().signUpWithFacebook();
                        },
                      ),
                    ],
                  )),
            ),
          );
  }
}