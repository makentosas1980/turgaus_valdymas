import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PropertyResult {
  String propertyId;
  String propertyAddress;

  PropertyResult({
    @required this.propertyId,
    @required this.propertyAddress,
  });
}

typedef StringValue = String Function(String);

final _document = FirebaseFirestore.instance.collection(firestoreProperty);

class AssignProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentUser = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Priskirti NT objektą'),
      ),
      body: StreamBuilder(
        stream: _document.where('userId', isEqualTo: currentUser).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            List list = [];
            for (var item in snapshot.data.docs) {
              if ((item.data().containsValue('Laisvas')) == true) {
                list.add(item);
              }
            }

            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(list[index]['address']),
                  subtitle: Text(list[index]['postcode']),
                  trailing: Text(list[index]['city']),
                  onTap: () {
                    String propertyId = "${list[index]['documentId']}";
                    String propertyAddress =
                        '''${list[index]['address']}\n${list[index]['postcode']}\n${list[index]['city']}
                    ''';
                    final result = PropertyResult(
                        propertyId: propertyId,
                        propertyAddress: propertyAddress);
                    Navigator.pop(context, result);
                    // callback(propertyAddress);
                    // callback2(propertyId);
                  },
                );
              },
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}
