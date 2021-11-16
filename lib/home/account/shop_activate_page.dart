import 'package:coffeasy/common_widgets/form_submit_button.dart';
import 'package:coffeasy/home/account/shop_set_up_page.dart';
import 'package:flutter/material.dart';

class ShopActivatePage extends StatelessWidget {
  const ShopActivatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activate Shop'),
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    //the buildContent is private as it is uniquely created
    //for the sign in page, so it's not reusable and hence
    //is unnecessary to be public.

    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 98),
            Text(
              'Activate your shop on Coffeasy now to receive pickup orders. ',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              'Your shop is not visible to customers until you are done setting up.',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 38,
            ),
            FormSubmitButton(text: 'Set up now', onPressed: () => ShopSetUpPage.show(context)),
          ],
        ),
      ),
    );
  }
}
