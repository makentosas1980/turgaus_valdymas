import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createIssue(
  String marketName,
  String pavilion,
  String premiseNumber,
  String description,
) async {
  var document = FirebaseFirestore.instance.collection(firestoreIssue).doc();
  try {
    document.set(
      {
        'documentId': document.id,
        'marketName': marketPlaceName,
        'pavilion': pavilion,
        'premiseNumber': premiseNumber,
        'message': description,
        'date': currentDate,
      },
    );
    return AuthMessage.addIssueMessage;
  } catch (e) {
    return 'Įvyko klaida, bandykite dar karta';
  }
}
