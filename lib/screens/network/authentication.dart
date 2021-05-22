// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baigiamasis/modules/globals.dart';

FirebaseAuth auth = FirebaseAuth.instance;

// Future<String> registerUser(
//   String name,
//   String surname,
//   String email,
//   String password,
// ) async {
//   User user;
//   String _signUpErrorMessage = '';

//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     user = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance.collection('users').doc().set({
//       'id': user.uid,
//       'name': name,
//       'surname': surname,
//       'email': email,
//     });
//     _signUpErrorMessage = AuthMessage.registerMessage;
//     return _signUpErrorMessage;
//   } on FirebaseAuthException catch (e) {
//     switch (e.code) {
//       case 'operation-not-allowed':
//         _signUpErrorMessage = 'Serverio klaida, bandykite dar kartą vėliau.';
//         break;
//       case 'email-already-in-use':
//         _signUpErrorMessage = 'El. Paštas jau naudojamas, prašome prisijungti.';
//         break;
//       default:
//         _signUpErrorMessage =
//             'Registracija nepavyko. Prašome, pabandykite dar kartą.';
//     }
//     return _signUpErrorMessage;
//   }
// }

Future<String> loginUser(String email, String password) async {
  String _loginMessage = '';
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    _loginMessage = AuthMessage.loginMesage;
    return _loginMessage;
  } catch (e) {
    switch (e.code) {
      case "wrong-password":
        _loginMessage = 'Neteisingas slaptažodis.';
        break;
      case "user-not-found":
        _loginMessage = 'Vartotojas nerastas arba neteisingas slaptažodis.';
        break;
      default:
        _loginMessage = 'Įvyko neapibrėžta klaida, bandykite vėliau.';
    }
    return _loginMessage;
  }
}

Future<bool> signOutUser() async {
  await auth.signOut();
  return true;
}
