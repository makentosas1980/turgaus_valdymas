import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/screens/ui/property_listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataController extends ShowProperties {
  Future getData(String collection) async {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection(collection).get();
    return snapshot;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection(firestoreProperty)
        .where(
          'pavilion',
          isGreaterThanOrEqualTo: queryString,
        )
        .get();
  }
}
