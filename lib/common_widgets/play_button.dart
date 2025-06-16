import 'package:flutter/material.dart';
import './../utils/responsive_font_size.dart';

class PlayButton extends StatelessWidget {
  final Map<String, dynamic> difficulty;
  final bool showLevelText;
  final Widget page; // Halaman tujuan navigasi

  const PlayButton({
    super.key,
    required this.difficulty,
    this.showLevelText = true,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.5 > 200 ? 200 : screenWidth * 0.5,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: difficulty['color'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                shadowColor: difficulty['color'].withOpacity(0.7),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PLAY',
                    style: TextStyle(
                      fontSize: responsiveFontSize(screenWidth, 20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  if (showLevelText)
                    Text(
                      'Level ${difficulty['level']}',
                      style: TextStyle(
                        fontSize: responsiveFontSize(screenWidth, 14),
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
