import 'package:intl/intl.dart';

class AuthMessage {
  static const loginMesage = 'Sėkmingai prisijungėte.';
  static const registerMessage = 'Jūs sėkmingai užsiregistravote.';
  static const addTenantMessage = 'Nuomininkas sėkmingai sukurtas';
  static const addPropertyMessage = 'NT objektas sėkmingai sukurtas';
  static const paymentAdded = 'Nuoma apmokėta';
  static const addIssueMessage = 'Pranešimas sukurtas';
}

bool isEmailValid(String value) {
  const emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regex = RegExp(emailRegex);
  return regex.hasMatch(value);
}

const firestoreTenant = 'tenant';
const firestoreProperty = 'premises';
const firestoreIssue = 'issues';
const firestoreMarketName = 'marketName';
const propertyStatusEmpty = 'Laisvas';
const properStatusRented = 'Išnuomotas';
const firestorePayment = 'payments';
const firestorePavilions = 'pavilions';

var marketPlaceName = 'Saulės Turgus';
var currentDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());
var currentTime = new DateFormat('kk:mm:ss').format(DateTime.now());
var currentPavilionName = '';
var totalAmmountToPrint = '';
bool visiblePaymentButton;
double totalAmmount;
double totalCollectedAmmount;
bool isRentPaid = false;

const sunMarket = 'Saulės Turgus';
const winterMarket = 'Žiemos Turgus';
const freedomMarket = 'Laivės Turgus';
