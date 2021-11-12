import 'package:coffeasy/APP/sign_in/email_sign_in_form.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmaiLSignInForm(auth: auth),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
