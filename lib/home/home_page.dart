import 'package:coffeasy/home/cupertino_home_scaffold.dart';
import 'package:coffeasy/home/menu_item/menu_page.dart';
import 'package:coffeasy/home/tab_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.menuItem;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.menuItem: (_) => MenuPage(),
      TabItem.modifier: (_) => Container(),
      TabItem.account: (_) => Container(),
    };
  }

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }
}
