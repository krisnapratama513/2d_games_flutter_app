import 'package:flutter/material.dart';
import '../common_widgets/app_bar.dart';
import '../common_widgets/play_button.dart';
import '../common_widgets/list_text_instruction.dart';
import '../utils/responsive_font_size.dart';

import 'snake.dart';

class SnakeInstructionPage extends StatefulWidget {
  const SnakeInstructionPage({super.key});

  @override
  State<SnakeInstructionPage> createState() => _SnakeInstructionPageState();
}

class _SnakeInstructionPageState extends State<SnakeInstructionPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(titleText: "SNAKE GAME"),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF353A3E), Color(0xFF282823)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instruksi awal
            Text(
              'Belum ada',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 25),
                color: Color(0xFFD7C9AE),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(height: responsiveFontSize(screenWidth, 30)),
            Text(
              'Makan Apelnya',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: responsiveFontSize(screenWidth, 20)),

            // List tanpa card, dengan ikon dan teks langsung
            ListTextInstruction(
              texts: [
                '-',
                '-',
              ],
              icon: Icons.check_circle,
              screenWidth: screenWidth,
            ),

            const Spacer(),

            PlayButton(
              difficulty: {'color': Colors.lightGreen},
              showLevelText: false,
              page: SnakeGamePage(), // Navigasi ke SudokuPage
            ),
          ],
        ),
      ),
    );
  }
}
