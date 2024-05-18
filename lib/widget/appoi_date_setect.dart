import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for DateFormat
import '../Theam/theme.dart';

class SelectDate extends StatefulWidget {
  final void Function(DateTime)? onDateSelected;

  const SelectDate({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late List<DateTime> dates;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    // Initialize dates list with current date and the next 3 days
    dates = List.generate(3, (index) => DateTime.now().add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          dates.length,
              (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildSelectableContainer(index, dates[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableContainer(int index, DateTime date) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(date);
        }
      },
      child: Container(
        height: 50, // Increased container height to accommodate the day name
        width: 120,
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.white : AppThemeData.primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selectedIndex == index ? AppThemeData.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${date.day}/${date.month}",
              style: TextStyle(
                color: selectedIndex == index ? AppThemeData.primaryColor : Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('EEEE').format(date), // Get the day name
              style: TextStyle(
                color: selectedIndex == index ? AppThemeData.primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12, // Decrease the font size of the day name
              ),
            ),
          ],
        ),
      ),
    );
  }
}
