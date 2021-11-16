import 'package:coffeasy/home/account/account_page.dart';
import 'package:coffeasy/home/account/shop_set_up_page.dart';
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

  //to access the navigator state of each tab
  final Map<TabItem, GlobalKey<NavigatorState>> navKeys = {
    TabItem.menuItem: GlobalKey<NavigatorState>(),
    TabItem.modifier: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.menuItem: (_) => MenuPage(),
      TabItem.modifier: (_) => ShopSetUpPage(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab){
      //pop to first route 
      navKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //maybePop() only pop if theres more than 1 route in the nav stack, true
      //return false if there's only 1 route and didnt pop
      onWillPop: () async => !await navKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navKeys: navKeys,
      ),
    );
  }
}
