import 'package:flutter/material.dart';

enum TabItem{menuItem, modifier, account}

class TabItemData{
  const TabItemData({required this.title, required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.menuItem: TabItemData(title: 'Menu Items', icon: Icons.book),
    TabItem.modifier: TabItemData(title: 'Modifier', icon: Icons.view_headline),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}