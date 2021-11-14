import 'package:coffeasy/home/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItemListTile extends StatelessWidget {
  const MenuItemListTile(
      {Key? key, required this.menuItem, required this.onTap})
      : super(key: key);
  final MenuItem menuItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menuItem.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
