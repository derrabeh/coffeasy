import 'package:coffeasy/APP/home_page.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeasy/APP/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//This page keeps track of if the user is signed in or not
//Decides which widget to return (HomePage or SignInPage)
class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      //rebuilt everytime the auth state changes
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return HomePage();
        } return Scaffold (
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
