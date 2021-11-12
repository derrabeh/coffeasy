import 'package:coffeasy/APP/sign_in/validators.dart';
import 'package:coffeasy/common_widgets/form_submit_button.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:flutter/material.dart';

enum EmailSignInFormType { signIn, register }
//enum is similar to a boolean but it carries more meaning
//if you add a forget PW scren, you can do
//enum EmailSignInFormType { signIn, register, forgotPassword }

class EmaiLSignInForm extends StatefulWidget with EmailAndPasswordValidators{
  EmaiLSignInForm({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  _EmaiLSignInFormState createState() => _EmaiLSignInFormState();
}

class _EmaiLSignInFormState extends State<EmaiLSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  //default enum value
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;

  void _submit() async{
    //print('email: ${_emailController.text}, password: ${_passwordController.text}');
    setState(() {
      _submitted = true;
    });
    try {
      if (_formType == EmailSignInFormType.signIn){
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.pop(context);
    } catch (e){
      print(e.toString());
    }
  }

  void _emailEditingComplete(){
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }


  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    //_emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign In';

    bool submitEnabled = widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password);
    //bool submitEnabled = _email.isNotEmpty  && _password.isNotEmpty;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        onPressed: submitEnabled ? _submit : (){},
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

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      textInputAction: TextInputAction.done,
      obscureText: true,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'yourEmail@mail.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
      //print in console the input
      //onChanged: (value) => print(value)
    );
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

  _updateState(){
    //everytime u change the pw and email, the console log updates ->
    //print('email: $_email, password: $_password');
    setState(() {
    });
  }
}
