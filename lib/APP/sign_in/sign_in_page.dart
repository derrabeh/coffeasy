import 'package:coffeasy/APP/sign_in/email_sign_in_page.dart';
import 'package:coffeasy/APP/sign_in/sign_in_button.dart';
import 'package:coffeasy/APP/sign_in/social_sign_in_button.dart';
import 'package:coffeasy/common_widgets/show_exception_alert_dialog.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }

    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
      //^ a user is created here
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => EmailSignInPage(),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffeasy'),
        elevation: 2,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
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
            SizedBox(height: 50, child: _buildHeader()),
            SizedBox(height: 48),
            SocialSignInButton(
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _isLoading ? (){} : () => _signInGoogle(context),
              assetName: 'images/google-logo.png',
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(height: 8),
            SignInButton(
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: _isLoading ? (){} : () => _signInWithEmail(context),
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
              onPressed: _isLoading ? (){} : () => _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }

}
