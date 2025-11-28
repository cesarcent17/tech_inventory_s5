import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tecnologia.dart';

class TecnologiaService {
  final CollectionReference _col =
      FirebaseFirestore.instance.collection('tecnologia');

  // CREATE
  Future<void> create(Tecnologia item) =>
      _col.add(item.toMap());

  // READ (stream)
  Stream<List<Tecnologia>> getAll() {
    return _col.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Tecnologia.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }

  // UPDATE
  Future<void> update(Tecnologia item) =>
      _col.doc(item.id).update(item.toMap());

  // DELETE
  Future<void> delete(String id) => _col.doc(id).delete();
}
