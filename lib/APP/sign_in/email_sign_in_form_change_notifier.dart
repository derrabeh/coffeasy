import 'package:coffeasy/APP/sign_in/email_sign_in_change_model.dart';
import 'package:coffeasy/common_widgets/form_submit_button.dart';
import 'package:coffeasy/common_widgets/show_exception_alert_dialog.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'email_sign_in_model.dart';

class EmaiLSignInFormChangeNotifier extends StatefulWidget {
  EmaiLSignInFormChangeNotifier({required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmaiLSignInFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _EmaiLSignInFormChangeNotifierState createState() => _EmaiLSignInFormChangeNotifierState();
}


class _EmaiLSignInFormChangeNotifierState extends State<EmaiLSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  //called when a widget is removed from the widget tree
  @override
  void dispose(){
    //print('dispose called');
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    //print('email: ${_emailController.text}, password: ${_passwordController.text}');
    //should only print once if form submission is disabled while waiting for response
    //print('submit called');
    try {
      //Artificial delay to test disabling multiple form submission while waiting for response
      //await Future.delayed(Duration(seconds: 3));
      await model.submit();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showExceptionAlertDialog(context,
          title: 'Sign In Failed',
          exception: e);
    }
  }

  //moves focus to password field when user press on 'next' after editing email
  //if email is invalid, focus stays on email
  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    model.updateWith(
      email: '',
      password: '',
      formType: model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      isLoading: false,
      submitted: false,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
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
        onPressed: model.canSubmit ? _submit : () {},
        text: model.primaryButtonText,
      ),
      SizedBox(
        height: 8,
      ),
      TextButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(model.secondaryButtonText),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      textInputAction: TextInputAction.done,
      obscureText: true,
      onChanged: (password) => model.updateWith(password: password),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'your_email@mail.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => model.updateWith(email: email),
      onEditingComplete: () => _emailEditingComplete(),
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

}
