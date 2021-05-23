import 'package:intl/intl.dart';

class AuthMessage {
  static const loginMesage = 'Sėkmingai prisijungėte.';
  static const registerMessage = 'Jūs sėkmingai užsiregistravote.';
  static const addTenantMessage = 'Nuomininkas sėkmingai sukurtas';
  static const addPropertyMessage = 'NT objektas sėkmingai sukurtas';
  static const paymentAdded = 'Nuoma apmokėta';
}

bool isEmailValid(String value) {
  const emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regex = RegExp(emailRegex);
  return regex.hasMatch(value);
}

const firestoreTenant = 'tenant';
const firestoreProperty = 'premises';
const firestoreMarketName = 'marketName';
const propertyStatusEmpty = 'Laisvas';
const properStatusRented = 'Išnuomotas';
const firestorePayment = 'payments';
const int $euro = 0x20AC;
var marketPlaceName = '';
var currentDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());
var currentPavilionName = '';
double totalAmmount;
double totalCollectedAmmount;
bool isRentPaid = false;

const sunMarket = 'Saulės Turgus';
const winterMarket = 'Žiemos Turgus';
const freedomMarket = 'Laivės Turgus';

class PropertyTypes {
  static const Map<int, String> typeWidget = const <int, String>{
    0: 'Kiems',
    1: 'Butas',
    2: 'Sodas',
    3: 'Sodyba',
    4: 'Oba'
  };
}
