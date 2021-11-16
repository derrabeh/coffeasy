import 'package:coffeasy/common_widgets/avatar.dart';
import 'package:coffeasy/common_widgets/show_alert_dialog.dart';
import 'package:coffeasy/home/account/shop_activate_page.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      defaultActionText: 'Logout',
    ) ??
        false;
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  void _shopActivatePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => ShopActivatePage(),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    //to access user obj in acc page:
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Log out',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: _buildUserInfo(auth.currentUser!),
        ),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget> [
        Avatar(photoUrl: user.photoURL, radius: 50),
        SizedBox(height: 10,),
        if (user.displayName != null)
          Text(
            user.displayName!,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget _buildContents(BuildContext context) {
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
            ListTile(
              title: Text('Activate Shop'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => _shopActivatePage(context),
            ),
            ListTile(
              title: Text('Coffee Pass'),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }

}
