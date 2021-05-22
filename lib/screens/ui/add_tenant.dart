// import 'package:baigiamasis/modules/globals.dart';
// import 'package:baigiamasis/modules/save_tenant.dart';
// import 'package:baigiamasis/screens/ui/assign_property_for_tenant.dart';
// import 'package:baigiamasis/screens/ui/tab_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';

// class AddTenant extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Sukirti Nuomininką',
//         ),
//       ),
//       body: TenantInputs(),
//     );
//   }
// }

// class TenantInputs extends StatefulWidget {
//   @override
//   _TenantInputsState createState() => _TenantInputsState();
// }

// class _TenantInputsState extends State<TenantInputs> {
//   String message;
//   String assignPropertyAddress;
//   String assignPropertyId;
//   String error;
//   bool isButtonDisabled = false;
//   final formKey = GlobalKey<FormState>();

//   TextEditingController _name = TextEditingController();
//   TextEditingController _surname = TextEditingController();
//   TextEditingController _phoneNumber = TextEditingController();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _rentStart = TextEditingController();
//   TextEditingController _rentEnd = TextEditingController();
//   TextEditingController _assignProperty = TextEditingController();

//   _showSnackbar(String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//       switch (selectedIndex) {
//         case 0:
//           titleName = 'NT valdymas';
//           break;
//         case 1:
//           titleName = 'NT sąrašas';
//           break;
//         case 2:
//           titleName = 'Nuominikų sąrašas';
//           break;
//         case 3:
//           titleName = 'Pridėti NT objektą';
//           break;
//         case 4:
//           titleName = 'Pridėti nuomininką';
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   autofocus: true,
//                   controller: _name,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Vardas',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   autofocus: true,
//                   controller: _surname,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Pavardė',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   autofocus: true,
//                   controller: _phoneNumber,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Tel. nr.',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   autofocus: true,
//                   controller: _email,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'El. paštas',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   controller: _rentStart,
//                   readOnly: true,
//                   enableInteractiveSelection: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Nuomos pradžia',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                   onTap: () async {
//                     final date = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2001),
//                         lastDate: DateTime(2024));
//                     setState(() {
//                       String formattedDate = new DateFormat.yMd().format(date);
//                       _rentStart.text = formattedDate;
//                     });
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   controller: _rentEnd,
//                   readOnly: true,
//                   enableInteractiveSelection: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Nuomos pabaiga',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                   onTap: () async {
//                     final date = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2001),
//                         lastDate: DateTime(2024));
//                     setState(() {
//                       String formattedDate = new DateFormat.yMd().format(date);
//                       _rentEnd.text = formattedDate;
//                     });
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 child: TextFormField(
//                   controller: _assignProperty,
//                   minLines: 1,
//                   maxLines: 3,
//                   readOnly: true,
//                   enableInteractiveSelection: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Pridėti NT objektą',
//                   ),
//                   validator: (value) {
//                     error = _checkFieldInput(value);
//                     return error;
//                   },
//                   onTap: () async {
//                     final result = await Navigator.push<PropertyResult>(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AssignProperty(),
//                       ),
//                     );
//                     setState(() {
//                       _assignProperty.text = result.propertyAddress;
//                       assignPropertyId = result.propertyId;
//                     });
//                   },
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
//                     //disabledColor: Colors.grey,
//                     onPressed: isButtonDisabled
//                         ? null
//                         : () async {
//                             if (formKey.currentState.validate()) {
//                               setState(() {
//                                 isButtonDisabled = true;
//                               });
//                               message = await createTenant(
//                                 _name.text,
//                                 _surname.text,
//                                 _phoneNumber.text,
//                                 _email.text,
//                                 _rentStart.text,
//                                 _rentEnd.text,
//                                 assignPropertyId,
//                               );

//                               if ((message) == AuthMessage.addTenantMessage) {
//                                 Navigator.pop(context, message);
//                               } else {
//                                 _showSnackbar(message);
//                               }
//                             }
//                           },
//                     child: Text('Sukurti'),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// String _checkFieldInput(String value) {
//   if (value.isEmpty) {
//     return 'Privalomas laukas';
//   } else {
//     return null;
//   }
// }
