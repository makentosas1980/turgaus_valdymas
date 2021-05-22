import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> payRent(
  String premisesId,
  String status,
  String ammount,
  String date,
) async {
  var document = FirebaseFirestore.instance.collection(firestorePayment).doc();
  try {
    document.set(
      {
        'documentId': premisesId,
        'status': status,
        'ammount': ammount,
        'date': date,
      },
    );
    return AuthMessage.paymentAdded;
  } catch (e) {
    return 'Įvyko klaida, bandykite dar karta';
  }
}
