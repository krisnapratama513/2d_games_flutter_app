import 'package:flutter/material.dart';
import '../common_widgets/app_bar.dart';
import '../common_widgets/play_button.dart';
import '../common_widgets/list_text_instruction.dart';
import '../utils/responsive_font_size.dart';

// import 'ticta.dart';
import 'tic_tac_toe.dart';

class TicTacInstructionPage extends StatefulWidget {
  const TicTacInstructionPage({super.key});

  @override
  State<TicTacInstructionPage> createState() => _TicTacInstructionPageState();
}

class _TicTacInstructionPageState extends State<TicTacInstructionPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(titleText: "Tic Tac Toe"),

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
              'Cara Main',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 25),
                color: Color(0xFFD7C9AE),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(height: responsiveFontSize(screenWidth, 30)),
            Text(
              '-',
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
                '',
                '',
              ],
              icon: Icons.check_circle,
              screenWidth: screenWidth,
            ),

            const Spacer(),

            PlayButton(
              difficulty: {'color': Colors.lightGreen},
              showLevelText: false,
              page: TicTacToePage(), // Navigasi ke SudokuPage
            ),
          ],
        ),
      ),
    );
  }
}
