
import 'package:coffeasy/APP/home_page.dart';
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
  //the ? makes _user nullable, instead of default non-nullable
  User? _user;

  @override
  void initState() {
    super.initState();
    _updateUser(FirebaseAuth.instance.currentUser);
  }

  //update the user from null to current user
  void _updateUser(User? user){
    setState(() {
      _user = user;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_user == null){
      //passes the User from onSignIn to _updateUser(User u)
      return SignInPage(onSignIn: (user) => _updateUser(user),);

    }
    return HomePage(
      //change current user to null
        onSignOut: () => _updateUser(null),
    );
  }
}
