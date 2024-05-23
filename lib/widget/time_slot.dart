import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class TimeSlot extends StatefulWidget {
  final void Function(String)? onTimeSelected;

  const TimeSlot({super.key, this.onTimeSelected});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  int selectedIndex = -1;

  // Function to convert index to time string in 12-hour format
  String indexToTime(int index) {
    int hour = 9 + (index ~/ 2);
    int minute = (index % 2) * 30;
    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }
    if (hour == 0) {
      hour = 12;
    }
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context); // Get the theme data

    return Container(
      color: AppThemeData.backgroundBlack,
      child: Column(
        children: List.generate(6, (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (innerIndex) {
              final containerIndex = index * 4 + innerIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = containerIndex;
                  });
                  if (widget.onTimeSelected != null) {
                    widget.onTimeSelected!(indexToTime(containerIndex));
                  }
                },
                child: Container(
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    color: selectedIndex == containerIndex ? Colors.white : themeData.primaryColor,
                    border: Border.all(
                      color: selectedIndex == containerIndex ? themeData.primaryColor : Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      indexToTime(containerIndex),
                      style: TextStyle(
                        fontSize: 15, // Adjust font size here
                        color: selectedIndex == containerIndex ? themeData.primaryColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }).map((widget) {
          return Column(
            children: [
              widget,
              const SizedBox(height: 12), // Add space between columns
            ],
          );
        }).toList(),
      ),
    );
  }
}
