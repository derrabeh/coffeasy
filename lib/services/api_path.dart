class APIPath{
  static String menuItem(String uid, String itemId) => 'shops/$uid/menuItem/$itemId';
  static String menuItems(String uid) => 'shops/$uid/menuItem';
  static String shop(String uid, String shopId) => 'shops/$uid/shop/$shopId';
}