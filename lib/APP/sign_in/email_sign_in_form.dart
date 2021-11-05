import 'package:coffeasy/common_widgets/form_submit_button.dart';
import 'package:flutter/material.dart';

enum EmailSignInFormType { signIn, register }

class EmaiLSignInForm extends StatefulWidget {
  const EmaiLSignInForm({Key? key}) : super(key: key);

  @override
  _EmaiLSignInFormState createState() => _EmaiLSignInFormState();
}

class _EmaiLSignInFormState extends State<EmaiLSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //default enum value
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() {
    print(
        'email: ${_emailController.text}, password: ${_passwordController
            .text}');
  }

  void _toggleFormType(){
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn ?
          EmailSignInFormType.register : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign In';
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'yourEmail@mail.com',
        ),
        //print in console the input
        //onChanged: (value) => print(value)
      ),
      SizedBox(
        height: 8,
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        onPressed: _submit,
        text: primaryText,
      ),
      SizedBox(
        height: 8,
      ),
      TextButton(
        onPressed: _toggleFormType,
        child: Text(secondaryText),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
