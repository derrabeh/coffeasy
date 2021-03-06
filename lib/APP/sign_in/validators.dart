

abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}

abstract class TextFieldValidator {
  String errorHint(String input);
}

class ShopSetUpValidators{
  final StringValidator shopNameValidator = NonEmptyStringValidator();
  final StringValidator locationValidator = NonEmptyStringValidator();
  final String invalidShopNameErrorText = 'Shop name can\'t be empty';
  final String invalidLocationErrorText = 'Location can\'t be empty';
}

//NOT USED
class EmailValidator implements TextFieldValidator {
  @override
  String errorHint(String input) {
    if (input.length < 7) {
      return 'Email must be more than 7 characters';
    } else if (!input.contains('@')) {
      return 'Email is not valid';
    }
    return '';
  }
}

//NOT USED
class PasswordValidator implements TextFieldValidator{
  @override
  String errorHint(String input){
    if(input.length <6){
      return 'Password must be more than 6 character';
    }
    return '';
  }
}

