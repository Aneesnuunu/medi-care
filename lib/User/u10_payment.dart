import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u11_payment_success.dart';
import '../widget/choose_payment.dart';
import '../widget/u10_clinic_details.dart';
import '../widget/u10_doctor_details.dart';

class PaymentPage extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const PaymentPage({super.key, this.selectedDate, this.selectedTime});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;

  void _confirmClinicVisit() {
    if (selectedPaymentMethod == 'Pay at Clinic') {
      // Reference to the user's document in Firestore
      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      // Update the user's document with the appointment details
      userDocRef.update({
        'appointments': FieldValue.arrayUnion([
          {
            'date': DateFormat('yyyy-MM-dd').format(widget.selectedDate!),
            'time': widget.selectedTime,
            'dayName': DateFormat('EEEE').format(widget.selectedDate!),
          }
        ])
      }).then((_) {
        // Navigate to the payment success page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaymentSuccessPage()),
        );
      }).catchError((error) {
        print('Failed to update appointment details: $error');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose "Pay at Clinic" as the payment mode.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: const Text(
              "Book in-Clinic Appointment",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const U10DoctorDetails(),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppThemeData.primaryColor,
                  borderRadius:
                      BorderRadius.circular(15.0), // Set border radius here
                ),
                height: 100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Appointment time",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      title: Text(
                        DateFormat('dd/MM/yyyy').format(widget.selectedDate!),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      subtitle: Text(
                        DateFormat('EEEE').format(widget.selectedDate!),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      trailing: Text(
                        widget.selectedTime ?? '',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const U10ClinicDetails(),
              const SizedBox(
                height: 15,
              ),
              ChoosePayment(
                onPaymentMethodSelected: (paymentMethod) {
                  setState(() {
                    selectedPaymentMethod = paymentMethod;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: _confirmClinicVisit,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    backgroundColor: AppThemeData.primaryColor,
                  ),
                  child: const Text(
                    "Confirm Clinic Visit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
