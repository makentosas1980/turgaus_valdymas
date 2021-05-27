import 'package:firebase_auth/firebase_auth.dart';
import 'package:baigiamasis/modules/globals.dart';

FirebaseAuth auth = FirebaseAuth.instance;

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
