import 'package:brew_crew/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication/authentication.dart';
import 'Home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
