import 'package:coffeasy/common_widgets/show_alert_dialog.dart';
import 'package:coffeasy/services/auth_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure you want to log out?',
        defaultActionText: 'Logout',
    ) ?? false;
    if (didRequestSignOut == true){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
      ),
    );
  }
}
