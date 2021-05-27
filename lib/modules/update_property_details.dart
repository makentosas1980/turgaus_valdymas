import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  String date;
  String ammount;
  bool status;

  Payment(this.date, this.ammount, this.status);

  Map<String, dynamic> toMap() => {
        "date": this.date,
        "ammount": this.ammount,
        "status": this.status,
      };
}

//ADD PAYMENT TO THE PROPERTY
addPayment(documentId, date, ammount, status) {
  Payment newPayment = Payment(date, ammount, status);
  FirebaseFirestore.instance
      .collection(firestoreProperty)
      .doc(documentId)
      .update(
    {
      "payments": FieldValue.arrayUnion(
        [
          newPayment.toMap(),
        ],
      ),
    },
  );
}

//UPDATE PROPERTY
Future<bool> updateProperty(
  String documentId,
  String pavilion,
  String premiseNumber,
  String ammountToPay,
) async {
  var document =
      FirebaseFirestore.instance.collection(firestoreProperty).doc(documentId);
  try {
    document.update(
      {
        'pavilion': pavilion,
        'premiseNumber': premiseNumber,
        'ammountToPay': ammountToPay,
      },
    );
    return true;
  } catch (e) {
    return false;
  }
}
