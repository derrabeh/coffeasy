class Shop {
  Shop({
    required this.id,
    required this.shopName,
    required this.location,
  });

  final String id;
  final String shopName;
  final String location;

  //factory is a constructor that doesn't always create a new instance
  //eg if data==null, then don't return a menu item object
  //for model classes, recommend to implement fromMap(data) and toMap
  factory Shop.fromMap(Map<String, dynamic> data, String documentId){
    if (data == null)
      throw AssertionError('data must not be null');
    final String shopName = data['shopName'];
    final String location = data['location'];
    return Shop(id: documentId, shopName: shopName, location: location, );
  }

  Map<String, dynamic> toMap(){
    return {
      'shopName' : shopName,
      'location' : location,
    };
  }
}
