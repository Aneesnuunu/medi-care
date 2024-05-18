import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class PrescriptionSheet extends StatefulWidget {
  final String name;
  final String age;
  final String place;
  final String date;

  const PrescriptionSheet({
    super.key,
    required this.name,
    required this.age,
    required this.place,
    required this.date,
  });

  @override
  State<PrescriptionSheet> createState() => _PrescriptionSheetState();
}

class _PrescriptionSheetState extends State<PrescriptionSheet> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController placeController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    placeController = TextEditingController(text: widget.place);
    dateController = TextEditingController(
        text: widget.date.split("T")[0]); // Display only date part
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    placeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppThemeData.primaryColor,
            width: 5.0,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/Images/logo.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medi-Care Clinic",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: AppThemeData.primaryColor),
                        ),
                        Row(
                          children: [
                            Text(
                              'Dr. Sarah Johnson ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'M.B.B.S , M.D',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Number 186/165,9th Main Road,14th Cross',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Ph: 9956982567 , 9946989015',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppThemeData.primaryColor,
                        width: 5.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Name:"),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text("Age:"),
                              const SizedBox(width: 10),
                              Text(
                                widget.age,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("Place:"),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget.place,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text("Date:"),
                              const SizedBox(width: 10),
                              Text(
                                widget.date.split("T")[0],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 10,
                            color: AppThemeData.primaryColor,
                            thickness: 5,
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Prescribe Medicine...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                child: const Text(
                  "Stop Consultation",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}













