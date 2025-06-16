import 'package:flutter/material.dart';

// Custom TextLabel widget with text, fontsize, and color parameters
class DifficultyLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const DifficultyLabel({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
