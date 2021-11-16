import 'package:coffeasy/common_widgets/avatar.dart';
import 'package:coffeasy/common_widgets/show_alert_dialog.dart';
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
    );
  }

  Widget _buildUserInfo(User? user) {
    return Column(
      children: <Widget> [
        Avatar(photoUrl: user!.photoURL, radius: 50),
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
}
