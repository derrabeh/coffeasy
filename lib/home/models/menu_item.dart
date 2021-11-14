class MenuItem {
  MenuItem({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final int price;

  //factory is a constructor that doesn't always create a new instance
  //eg if data==null, then don't return a menu item object
  //for model classes, recommend to implement fromMap(data) and toMap
  factory MenuItem.fromMap(Map<String, dynamic> data, String documentId){
    if (data == null)
      throw AssertionError('data must not be null');
    final String name = data['name'];
    final int price = data['price'];
    return MenuItem(id: documentId, name: name, price: price, );
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'price' : price,
    };
  }
}
