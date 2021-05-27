// import 'package:baigiamasis/modules/globals.dart';
// import 'package:baigiamasis/modules/print_receipt.dart';
// import 'package:baigiamasis/screens/ui/property_details.dart';
// import 'package:baigiamasis/screens/ui/update_property.dart';
// import 'package:flutter/material.dart';

// bool main;

// class GetButtons extends StatelessWidget {
//   final String marketNametoPrint;
//   final String pavilionToPrint;
//   final String premiseNumberToPrint;
//   final String ammountToPayToPrint;
//   final String dateToPrint;
//   final String documentId;

//   const GetButtons({
//     Key key,
//     this.marketNametoPrint,
//     this.pavilionToPrint,
//     this.premiseNumberToPrint,
//     this.ammountToPayToPrint,
//     this.dateToPrint,
//     this.documentId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             FloatingActionButton.extended(
//               heroTag: 'redaguoti',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UpdateProperty(
//                       documentId: documentId,
//                       pavilion: pavilionToPrint,
//                       premiseNumber: premiseNumberToPrint,
//                       ammountToPay: ammountToPayToPrint,
//                     ),
//                   ),
//                 );
//               },
//               label: Text('Redaguoti'),
//             ),
//             Visibility(
//               visible: setState(),
//               child: FloatingActionButton.extended(
//                 heroTag: 'sumoketa',
//                 onPressed: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PrintReceipt(
//                         marketNametoPrint: marketPlaceName,
//                         pavilionToPrint: pavilionToPrint,
//                         premiseNumberToPrint: premiseNumberToPrint,
//                         ammountToPayToPrint: '$ammountToPayToPrint€',
//                         dateToPrint: currentDate,
//                         documentId: documentId,
//                       ),
//                     ),
//                   ).then(
//                     (value) => PropertyDetails(
//                       documentId: documentId,
//                     ),
//                   );
//                 },
//                 label: Text('Sumokėti'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// setState() {
//   main = visiblePaymentButton;
//   return true;
// }
