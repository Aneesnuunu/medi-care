// import 'package:flutter/material.dart';
// import 'package:upi_pay/upi_pay.dart';
// import 'package:uuid/uuid.dart';
//
// class UpiPaymentPage extends StatefulWidget {
//   const UpiPaymentPage({super.key});
//
//   @override
//   _UpiPaymentPageState createState() => _UpiPaymentPageState();
// }
//
// class _UpiPaymentPageState extends State<UpiPaymentPage> {
//   List<ApplicationMeta> _apps = [];
//   final String receiverUpiAddress = 'receiver@upi';
//   final String receiverName = 'Receiver Name';
//   final String amount = '1.00';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchApps();
//   }
//
//   Future<void> _fetchApps() async {
//     List<ApplicationMeta> apps = await UpiPay.getInstalledUpiApplications();
//     setState(() {
//       _apps = apps;
//     });
//   }
//
//   void _initiateTransaction(ApplicationMeta app) async {
//     var uuid = Uuid();
//     String transactionRef = uuid.v4(); // Generate a unique transaction reference
//
//     UpiTransactionResponse response = await UpiPay.initiateTransaction(
//       app: app.upiApplication,
//       receiverUpiAddress: receiverUpiAddress,
//       receiverName: receiverName,
//       transactionRef: transactionRef,
//       transactionNote: 'Test Payment',
//       amount: amount,
//     );
//
//     _handleTransactionResponse(response);
//   }
//
//   void _handleTransactionResponse(UpiTransactionResponse response) {
//     print(response);
//     // Handle the response here (e.g., show success or failure message)
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('UPI Payment'),
//       ),
//       body: Column(
//         children: [
//           Text('Select UPI App to Pay'),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _apps.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   // leading: Image.memory(_apps[index].icon),
//                   // title: Text(_apps[index].name),
//                   onTap: () => _initiateTransaction(_apps[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
