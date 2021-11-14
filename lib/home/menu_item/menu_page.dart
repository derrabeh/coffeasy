import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeasy/common_widgets/show_alert_dialog.dart';
import 'package:coffeasy/common_widgets/show_exception_alert_dialog.dart';
import 'package:coffeasy/home/menu_item/edit_menu_item_page.dart';
import 'package:coffeasy/home/menu_item/empty_content.dart';
import 'package:coffeasy/home/menu_item/menu_item_list_tile.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:coffeasy/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeasy/home/models/menu_item.dart';

class MenuPage extends StatelessWidget {
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

  // NO LONGER NEEDED
  Future<void> _createMenuItem(BuildContext context) async {
    try {
      //final database = Provider.of<Database>(context, listen: false);
      //await database.setMenuItem(MenuItem(name: 'Latte', price: 10));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation failed', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final db = Provider.of<Database>(context, listen: false);
    //db.menuItemStream();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Menu',
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
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => EditMenuItemPage.show(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<MenuItem>>(
      stream: database.menuItemStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data;
          //shows if there's menu items
          if (items!.isNotEmpty) {
            final children = items!
                .map((item) => MenuItemListTile(
                      menuItem: item,
                      onTap: () =>
                          EditMenuItemPage.show(context, menuItem: item),
                    ))
                .toList();
            return ListView(children: children);
          }
          //shows if nothing in the menu item collection
          return EmptyContent();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some error occured'));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
