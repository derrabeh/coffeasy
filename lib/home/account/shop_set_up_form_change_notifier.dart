import 'package:coffeasy/common_widgets/form_submit_button.dart';
import 'package:coffeasy/common_widgets/show_exception_alert_dialog.dart';
import 'package:coffeasy/home/account/shop_set_up_change_model.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopSetUpFormChangeNotifier extends StatefulWidget {
  ShopSetUpFormChangeNotifier({required this.model});
  final ShopSetUpChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ShopSetUpChangeModel>(
      create: (_) => ShopSetUpChangeModel(auth: auth),
      child: Consumer<ShopSetUpChangeModel>(
        builder: (_, model, __) => ShopSetUpFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _ShopSetUpFormChangeNotifierState createState() => _ShopSetUpFormChangeNotifierState();
}


class _ShopSetUpFormChangeNotifierState extends State<ShopSetUpFormChangeNotifier> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _shopNameFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();

  ShopSetUpChangeModel get model => widget.model;

  //called when a widget is removed from the widget tree
  @override
  void dispose(){
    //print('dispose called');
    _shopNameController.dispose();
    _locationController.dispose();
    _shopNameFocusNode.dispose();
    _locationFocusNode.dispose();
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
          title: 'Set Up Failed',
          exception: e);
    }
  }

  //moves focus to password field when user press on 'next' after editing email
  //if email is invalid, focus stays on email
  void _shopNameEditingComplete() {
    //TODO: change to shop name validator
    final newFocus = model.shopNameValidator.isValid(model.shopName)
        ? _locationFocusNode
        : _shopNameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }


  List<Widget> _buildChildren() {
    return [
      _buildShopNameTextField(),
      SizedBox(
        height: 8,
      ),
      _buildLocationTextField(),
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
        onPressed: (){},
        child: Text(model.secondaryButtonText),
      ),
    ];
  }

  TextField _buildLocationTextField() {
    return TextField(
      controller: _locationController,
      focusNode: _locationFocusNode,
      decoration: InputDecoration(
        labelText: 'Location',
        hintText: 'The pickup location of your establishment',
        errorText: model.locationErrorText,
        enabled: model.isLoading == false,
      ),
      textInputAction: TextInputAction.done,
      obscureText: true,
      //onChanged: (password) => model.updateWith(password: password),
      onEditingComplete: _submit,
    );
  }

  TextField _buildShopNameTextField() {
    return TextField(
      controller: _shopNameController,
      focusNode: _shopNameFocusNode,
      decoration: InputDecoration(
        labelText: 'Shop Name',
        errorText: model.shopNameErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      //onChanged: (email) => model.updateWith(email: email),
      onEditingComplete: () => _shopNameEditingComplete(),
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
