import 'package:coffeasy/home/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key? key,
      required this.currentTab,
      required this.onSelectTab,
      required this.widgetBuilders,
      required this.navKeys})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.lightBlue,
        inactiveColor: Colors.grey,
        items: [
          _buildItem(TabItem.menuItem),
          _buildItem(TabItem.modifier),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) => widgetBuilders[item]!(context),
          navigatorKey: navKeys[item],
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.lightBlue : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData!.icon,
        color: color,
      ),
      label: itemData.title,
    );
  }
}
