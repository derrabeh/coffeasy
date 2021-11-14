import 'package:coffeasy/common_widgets/show_alert_dialog.dart';
import 'package:coffeasy/common_widgets/show_exception_alert_dialog.dart';
import 'package:coffeasy/home/models/menu_item.dart';
import 'package:coffeasy/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: Improve usability with FocusNodes
//TODO: Make page more robust with loading state

class EditMenuItemPage extends StatefulWidget {
  //this.menuItem not required as this page is compatible with
  //both edit (item exist) and add (item null)
  const EditMenuItemPage({Key? key, required this.database, this.menuItem})
      : super(key: key);
  final Database database;
  final MenuItem? menuItem;

  //show this page when the + button is pressed
  static Future<void> show(BuildContext context, {MenuItem? menuItem}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditMenuItemPage(
              database: database,
              menuItem: menuItem,
            ),
        fullscreenDialog: true));
  }

  @override
  _EditMenuItemPageState createState() => _EditMenuItemPageState();
}

class _EditMenuItemPageState extends State<EditMenuItemPage> {
  //to access the state of the form
  final _formKey = GlobalKey<FormState>();
   String? _name;
   int? _price;

  @override
  void initState(){
    super.initState();
    if(widget.menuItem != null) {
      _name = widget.menuItem!.name;
      _price = widget.menuItem!.price;
    }
  }

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
      try {
        //print ('form saved, name: $_name, price: $_price');
        //to enforce unique menu item names:
        final items = await widget.database.menuItemStream().first;
        final allNames = items.map((item) => item.name).toList();
        //if item exists, exclude the current job name from list of allNames
        if (widget.menuItem != null){
          allNames.remove(widget.menuItem!.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(context,
              title: 'Name already used',
              content: 'Please choose a different item name',
              defaultActionText: 'OK');
        } else {
          //if item exist, get from widget, if not get from documentIdFrom...()
          final id = widget.menuItem?.id ?? documentIdFromCurrentDate();
          final item = MenuItem(id: id, name: _name!, price: _price!);
          await widget.database.setMenuItem(item);
          Navigator.pop(context);
        }
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
        elevation: 2,
        //checks menuItem null or not and change title accordingly
        title: Text(widget.menuItem == null ? 'Add Menu Item' : 'Edit Menu Item'),
        actions: <Widget>[
          TextButton(
            onPressed: _submit,
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: _buildContents(),
    );
  }

  //use Card( child: Placeholder()); to stimulate content....
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
        decoration: InputDecoration(labelText: 'Item name'),
        initialValue: _name,
        validator: (value) => value!.isNotEmpty ? null : 'Name cannot be empty',
        onSaved: (value) => _name = value!,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Price'),
        initialValue: _price != null ? '$_price' : null,
        //provide integer keyboard
        keyboardType: TextInputType.numberWithOptions(signed: false),
        validator: (value) =>
            value!.isNotEmpty ? null : 'Price cannot be empty',
        onSaved: (value) => _price = int.tryParse(value!) ?? 0,
      ),
    ];
  }
}
