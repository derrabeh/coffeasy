
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeasy/APP/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

//This page keeps track of if the user is signed in or not
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user; //the ? makes _user nullable, instead of default non-nullable

  void _updateUser(User user){
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null){
      return SignInPage(onSignIn: _updateUser,);
    }
    return Container();
  }
}
