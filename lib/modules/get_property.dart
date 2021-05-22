import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetProperty extends StatelessWidget {
  final String propertyId;

  GetProperty(this.propertyId);

  @override
  Widget build(BuildContext context) {
    final property = FirebaseFirestore.instance.collection(firestoreProperty);
    if ((propertyId) == '') {
      return Text('Nėra duomenų');
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future: property.doc(propertyId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Kažkas ne taip, bandykite dar kartą vėliau.");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            if (data['userId'] == FirebaseAuth.instance.currentUser.uid) {
              return Text(
                "${data['address']}\n${data['postcode']}\n${data['city']}\n${data['numberOfRooms']} k. \n${data['squareMeters']}\u33A1",
                style: TextStyle(fontSize: 20),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }
}
