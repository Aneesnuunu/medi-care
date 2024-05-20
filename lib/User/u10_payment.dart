
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u11_payment_success.dart';
import '../widget/choose_payment.dart';
import '../widget/u10_clinic_details.dart';
import '../widget/u10_doctor_details.dart';
import 'package:provider/provider.dart';

class PaymentPageModel extends ChangeNotifier {
  String? selectedPaymentMethod;

  void setSelectedPaymentMethod(String paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }
}

class PaymentPage extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const PaymentPage({super.key, this.selectedDate, this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentPageModel(),
      child: _PaymentPageContent(selectedDate: selectedDate, selectedTime: selectedTime),
    );
  }
}

class _PaymentPageContent extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const _PaymentPageContent({Key? key, this.selectedDate, this.selectedTime})
      : super(key: key);

  @override
  State<_PaymentPageContent> createState() => _PaymentPageContentState();
}

class _PaymentPageContentState extends State<_PaymentPageContent> {
  void _confirmClinicVisit(PaymentPageModel model) {
    if (model.selectedPaymentMethod == 'Pay at Clinic') {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final appointmentRef = FirebaseFirestore.instance.collection('User')
            .doc(currentUser.uid)
            .collection('appointments')
            .doc(); // Generate a new document ID

        appointmentRef.set({
          'date': DateFormat('yyyy-MM-dd').format(widget.selectedDate!),
          'time': widget.selectedTime,
          'dayName': DateFormat('EEEE').format(widget.selectedDate!),
        }).then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentSuccessPage()),
          );
        }).catchError((error) {
          print('Failed to update appointment details: $error');
        });
      }
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
    final model = Provider.of<PaymentPageModel>(context);

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
                    const Row(
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
                      leading: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      title: Text(
                        DateFormat('dd/MM/yyyy').format(widget.selectedDate!),
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      subtitle: Text(
                        DateFormat('EEEE').format(widget.selectedDate!),
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      trailing: Text(
                        widget.selectedTime ?? '',
                        style: const TextStyle(fontSize: 15, color: Colors.white),
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
                  model.setSelectedPaymentMethod(paymentMethod);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _confirmClinicVisit(model),
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
