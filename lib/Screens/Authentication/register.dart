import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleVeiw;
  Register({this.toggleVeiw});

  @override
  _RegisterState createState() => _RegisterState();
}

bool loading = false;
String email = '';
String password = '';
String error = '';

final AuthServices _auth = AuthServices();
final _formKey = GlobalKey<FormState>();

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return
        // loading
        //     ? Loading()
        //     :
        Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Sign Up to brew crew"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                print("object");
                widget.toggleVeiw();
              },
              icon: Icon(Icons.person),
              label: Text("Sign in"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                validator: (val) => val.length < 8
                    ? 'Enter your password 8 char at least,pls'
                    : null,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.black,
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please supply a vaild email';
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
            ],
          ),
        ),
      ),
    );
  }
}
