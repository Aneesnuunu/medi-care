
import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class ChoosePayment extends StatefulWidget {
  const ChoosePayment({Key? key, required this.onPaymentMethodSelected})
      : super(key: key);

  final Function(String) onPaymentMethodSelected;

  @override
  State<ChoosePayment> createState() => _ChoosePaymentState();
}

class _ChoosePaymentState extends State<ChoosePayment> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeData.primaryColor,
        borderRadius: BorderRadius.circular(15.0), // Set border radius here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose a Mode of Payment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'Pay Online';
                widget.onPaymentMethodSelected(selectedPaymentMethod!);
              });
            },
            leading: const Icon(
              Icons.payment,
              color: Colors.white,
            ),
            title: const Text(
              "Pay Online\n₹300",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            trailing: selectedPaymentMethod == 'Pay Online'
                ? const Icon(
              Icons.check,
              color: Colors.white,
            )
                : null,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'Pay at Clinic';
                widget.onPaymentMethodSelected(selectedPaymentMethod!);
              });
            },
            leading: const Icon(
              Icons.store,
              color: Colors.white,
            ),
            title: const Text(
              "Pay at Clinic\n₹300",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            trailing: selectedPaymentMethod == 'Pay at Clinic'
                ? const Icon(
              Icons.check,
              color: Colors.white,
            )
                : null,
          ),
        ],
      ),
    );
  }
}

