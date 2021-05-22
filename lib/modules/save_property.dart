import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createProperty(
  String marketName,
  String pavilion,
  String premiseNumber,
  String ammountToPay,
) async {
  var document = FirebaseFirestore.instance.collection(firestoreProperty).doc();
  try {
    document.set(
      {
        'documentId': document.id,
        'marketName': marketPlaceName,
        'pavilion': pavilion,
        'premiseNumber': premiseNumber,
        'ammountToPay': ammountToPay,
        'payments': [],
      },
    );
    return AuthMessage.addPropertyMessage;
  } catch (e) {
    return 'Įvyko klaida, bandykite dar karta';
  }
}
