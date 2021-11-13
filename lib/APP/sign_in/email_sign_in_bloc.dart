import 'dart:async';
import 'package:coffeasy/APP/sign_in/email_sign_in_model.dart';
import 'package:coffeasy/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    //print('email: ${_emailController.text}, password: ${_passwordController.text}');
    //should only print once if form submission is disabled while waiting for response
    //print('submit called');
    updateWith(submitted: true, isLoading: true);
    try {
      //Artificial delay to test disabling multiple form submission while waiting for response
      //await Future.delayed(Duration(seconds: 3));
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      //print(e.toString());
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType(){
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    _model = _model.copyWith(email: email, password: password, formType: formType, isLoading: isLoading, submitted: submitted);
    _modelController.add(_model);
  }
}
