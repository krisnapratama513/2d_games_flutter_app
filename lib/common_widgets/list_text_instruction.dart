import 'package:flutter/material.dart';
import '../utils/responsive_font_size.dart';

class ListTextInstruction extends StatelessWidget {
  final List<String> texts;
  final IconData icon;
  final double screenWidth;

  const ListTextInstruction({
    super.key,
    required this.texts,
    required this.icon,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(texts.length * 2 - 1, (index) {
          if (index.isEven) {
            final textIndex = index ~/ 2;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF9C27B0),
                  size: responsiveFontSize(screenWidth, 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    texts[textIndex],
                    style: TextStyle(
                      fontSize: responsiveFontSize(screenWidth, 20),
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox(height: responsiveFontSize(screenWidth, 12));
          }
        }),
      ],
    );
  }
}
