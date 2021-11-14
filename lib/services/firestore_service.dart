import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  //make this class accessible via a singleton object only
  //disable multiple instances of firestoreService
  //private constructor:
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData(
      {String? path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path!);
    print('$path: $data');
    await reference.set(data);
  }

  Stream<List<T>> collectionStream<T> ({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }){
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((snapshot) => builder(snapshot.data(), snapshot.id),).toList());
  }
}