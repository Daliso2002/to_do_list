import 'package:flutter/material.dart';
import 'package:testone/main.dart';

class DaySquare extends StatelessWidget {
  final String day;
  final String taskPreview;

  DaySquare({
    super.key,
    required this.day,
    required this.taskPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(taskPreview, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
