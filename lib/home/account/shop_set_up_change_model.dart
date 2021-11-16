import 'package:coffeasy/APP/sign_in/validators.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShopSetUpChangeModel with ChangeNotifier,ShopSetUpValidators  {
  ShopSetUpChangeModel({
    required this.auth,
    this.shopName = '',
    this.location = '',
    this.isLoading = false,
    this.submitted = false});

  final AuthBase auth;
  String shopName;
  String location;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    //print('email: ${_emailController.text}, password: ${_passwordController.text}');
    //should only print once if form submission is disabled while waiting for response
    //print('submit called');
    try {
      //Artificial delay to test disabling multiple form submission while waiting for response
      //await Future.delayed(Duration(seconds: 3));
      //TODO: add shop name and shop location
      //await auth.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  String get primaryButtonText {
    return 'Finish Set Up';
  }

  String get secondaryButtonText {
    return 'Shop will only appear to users after setting up';
  }

  bool get canSubmit {
    return locationValidator.isValid(location) &&
        shopNameValidator.isValid(shopName) &&
        !isLoading;
    //bool submitEnabled = _email.isNotEmpty  && _password.isNotEmpty;
    //!_isLoading ensure form is not enabled while it's loading
  }

  String? get locationErrorText {
    bool showErrorText = submitted && !locationValidator.isValid(location);
    return showErrorText ? invalidLocationErrorText : null;
  }

  String? get shopNameErrorText {
    bool showErrorText = submitted && !shopNameValidator.isValid(shopName);
    return showErrorText ? invalidShopNameErrorText : null;
  }

}
