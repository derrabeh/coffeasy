import 'package:coffeasy/home/models/menu_item.dart';
import 'package:coffeasy/services/api_path.dart';
import 'package:coffeasy/services/firestore_service.dart';

abstract class Database {
  Future<void> setMenuItem(MenuItem item);
  Stream<List<MenuItem>> menuItemStream();
}

//returns the current dateTime in String format,
//which is a unique id for our doc
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid != null);
  final String uid;

  //only one instance of FirestoreService can be called
  final _service = FirestoreService.instance;

  //single set method for create and update
  //.setData write data regardless if new or existing obj
  Future<void> setMenuItem(MenuItem item) => _service.setData(
        path: APIPath.menuItem(uid, item.id),
        data: item.toMap(),
      );

  //print all docs from firebase collection
  Stream<List<MenuItem>> menuItemStream() => _service.collectionStream(
    path: APIPath.menuItems(uid),
    builder: (data, documentId) => MenuItem.fromMap(data, documentId),
  );


}
