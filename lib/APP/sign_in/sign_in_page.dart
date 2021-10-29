import 'package:coffeasy/APP/sign_in/sign_in_button.dart';
import 'package:coffeasy/APP/sign_in/social_sign_in_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffeasy'),
        elevation: 2,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    //the buildContent is private as it is uniquely created
    //for the sign in page, so it's not reusable and hence
    //is unnecessary to be public.
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 48),
            SocialSignInButton(
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: () {},
              assetName: 'images/google-logo.png',
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(height: 8),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF334D92),
              onPressed: () {},
            ),
            SizedBox(height: 8),
            SignInButton(
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: () {},
            ),
            SizedBox(height: 8),
            Text(
              'or',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            SignInButton(
              text: 'Go anonymous',
              textColor: Colors.black,
              color: Colors.lime,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
