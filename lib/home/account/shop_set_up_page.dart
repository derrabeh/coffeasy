import 'package:coffeasy/home/account/shop_set_up_form_change_notifier.dart';
import 'package:flutter/material.dart';

class ShopSetUpPage extends StatelessWidget {
  const ShopSetUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set up your shop'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: ShopSetUpFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
