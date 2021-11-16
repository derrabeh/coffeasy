import 'package:coffeasy/APP/sign_in/validators.dart';

class ShopSetUpModel with ShopSetUpValidators {
  ShopSetUpModel(
      {this.shopName = '',
        this.location = '',
        this.isLoading = false,
        this.submitted = false});

  final String shopName;
  final String location;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText {
    return 'Finish Set Up';
  }

  String get secondaryButtonText {
    return 'Your shop will only appear in Coffeasy after setting up';
  }

  bool get canSubmit {
    return shopNameValidator.isValid(shopName) &&
        locationValidator.isValid(location) &&
        !isLoading;
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

  ShopSetUpModel copyWith({
    String? shopName,
    String? location,
    bool? isLoading,
    bool? submitted,
  }) {
    return ShopSetUpModel(
      shopName: shopName ?? this.shopName,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
