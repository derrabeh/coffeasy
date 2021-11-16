import 'package:coffeasy/common_widgets/form_submit_button.dart';
import 'package:coffeasy/common_widgets/show_exception_alert_dialog.dart';
import 'package:coffeasy/home/account/shop_set_up_form_change_notifier.dart';
import 'package:coffeasy/home/models/shop.dart';
import 'package:coffeasy/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopSetUpPage extends StatefulWidget {
  const ShopSetUpPage({Key? key, required this.database, this.shop}) : super(key: key);
  final Database database;
  final Shop? shop;

  //called from ShopActivatePage to pass database
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    //root navigator: true to hide the bottom tab
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ShopSetUpPage(
          database: database,
        ),
        fullscreenDialog: true));
  }

  @override
  _ShopSetUpPageState createState() => _ShopSetUpPageState();
}

class _ShopSetUpPageState extends State<ShopSetUpPage> {
  //to access the state of the form
  final _formKey = GlobalKey<FormState>();
  String? _shopName;
  String? _location;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //validate and save form
  //submit data to firestore
  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try{
        final id = documentIdFromCurrentDate();
        final shop = Shop(id: id, shopName: _shopName!, location: _location!);
        await widget.database.setShop(shop);
        Navigator.pop(context);

      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: 'Operation failed', exception: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set up your shop'),
        elevation: 2,
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Shop Name'),
        initialValue: _shopName,
        validator: (value) => value!.isNotEmpty ? null : 'Shop name cannot be empty',
        onSaved: (value) => _shopName = value!,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Location'),
        initialValue: _location != null ? '$_location' : null,
        validator: (value) =>
        value!.isNotEmpty ? null : 'Location cannot be empty',
        onSaved: (value) => _location = value!,
      ),
      SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        onPressed: _submit,
        text: 'Finish set up',
      ),
    ];
  }
}

