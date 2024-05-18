// import 'package:flutter/material.dart';
// import 'package:medi_care/Theam/theme.dart';
// import 'package:medi_care/User/u10_payment.dart';
// import 'package:medi_care/widget/appoi_date_setect.dart';
// import '../widget/time_slot.dart';
//
// class BookAppointment extends StatefulWidget {
//   const BookAppointment({Key? key});
//
//   @override
//   State<BookAppointment> createState() => _BookAppointmentState();
// }
//
// class _BookAppointmentState extends State<BookAppointment> {
//   DateTime? selectedDate;
//   String? selectedTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(70),
//           child: AppBar(
//             title: const Text(
//               "Book Your Appointment",
//               style: TextStyle(
//                 color: AppThemeData.primaryColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30),
//               const Text(
//                 "Select Date",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                   color: AppThemeData.primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               SelectDate(
//                 onDateSelected: (date) {
//                   setState(() {
//                     selectedDate = date;
//                   });
//                 },
//               ),
//               const SizedBox(height: 40),
//               const Text(
//                 "Time Slot",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                   color: AppThemeData.primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               TimeSlot(
//                 onTimeSelected: (time) {
//                   setState(() {
//                     selectedTime = time;
//                   });
//                 },
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 height: 50,
//                 width: MediaQuery.of(context).size.width,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (selectedDate != null && selectedTime != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const PaymentPage(),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please select both date and time.'),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(11)),
//                     ),
//                     backgroundColor: AppThemeData.primaryColor,
//                   ),
//                   child: const Text(
//                     "Book Appointment",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
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
import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u10_payment.dart';
import 'package:medi_care/widget/appoi_date_setect.dart';
import '../widget/time_slot.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: const Text(
              "Book Your Appointment",
              style: TextStyle(
                color: AppThemeData.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Select Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppThemeData.primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              SelectDate(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              const SizedBox(height: 40),
              const Text(
                "Time Slot",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppThemeData.primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              TimeSlot(
                onTimeSelected: (time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedDate != null && selectedTime != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            selectedDate: selectedDate,
                            selectedTime: selectedTime,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select both date and time.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    backgroundColor: AppThemeData.primaryColor,
                  ),
                  child: const Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
