// import 'package:baigiamasis/modules/globals.dart';
// import 'package:baigiamasis/screens/ui/home_page.dart';
// import 'package:baigiamasis/screens/network/authentication.dart';
// import 'package:flutter/material.dart';

// String _message = '';

// class SignupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NT valdymas'),
//       ),
//       body: TextInputWidget(),
//     );
//   }
// }

// class TextInputWidget extends StatefulWidget {
//   @override
//   _TextInputWidgetState createState() => _TextInputWidgetState();
// }

// class _TextInputWidgetState extends State<TextInputWidget> {
//   TextEditingController _name = TextEditingController();
//   TextEditingController _surname = TextEditingController();
//   TextEditingController _emailField = TextEditingController();
//   TextEditingController _passwordField = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _name.dispose();
//     _surname.dispose();
//     _emailField.dispose();
//     _passwordField.dispose();
//     super.dispose();
//   }

//   _clearInputs() {
//     _name.clear();
//     _surname.clear();
//     _emailField.clear();
//     _passwordField.clear();
//   }

//   _showSnackbar(String message) {
//     final snackBar = SnackBar(content: Text(_message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   _checkRegisterDetails() {
//     if ((_message) == AuthMessage.registerMessage) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeView(),
//         ),
//       );
//       _clearInputs();
//     }
//   }

//   @override
//   build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: TextFormField(
//                   controller: _name,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Vardas',
//                   ),
//                   validator: (value) {
//                     if (value.trim().isEmpty) {
//                       return 'Privalomas laukas';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: TextFormField(
//                   controller: _surname,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Pavardė',
//                   ),
//                   validator: (value) {
//                     if (value.trim().isEmpty) {
//                       return 'Privalomas laukas';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: TextFormField(
//                   controller: _emailField,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'El. paštas',
//                   ),
//                   validator: (value) {
//                     if (value.trim().isEmpty) {
//                       return 'Privalomas laukas';
//                     } else if (isEmailValid(value.trim())) {
//                       return null;
//                     } else {
//                       return 'Neteisingas el. pašto adresas formatas';
//                     }
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: TextFormField(
//                   controller: _passwordField,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Slaptažodis',
//                   ),
//                   validator: (value) {
//                     if (value.trim().isEmpty || value.trim().length < 6) {
//                       return 'Slaptažodį turi sudaryti mažiausiai 6 simboliai';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 44,
//                   child: TextButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.blue),
//                         foregroundColor:
//                             MaterialStateProperty.all(Colors.white),
//                         overlayColor:
//                             MaterialStateProperty.all(Colors.blueAccent)),
//                     onPressed: () async {
//                       if (_formKey.currentState.validate()) {
//                         _message = await registerUser(
//                           _name.text.trim(),
//                           _surname.text.trim(),
//                           _emailField.text.trim(),
//                           _passwordField.text.trim(),
//                         );
//                         _checkRegisterDetails();
//                         _showSnackbar(_message);
//                       }
//                     },
//                     child: Text('Registruotis'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
