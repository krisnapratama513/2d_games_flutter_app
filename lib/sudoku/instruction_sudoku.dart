import 'package:flutter/material.dart';
import 'main_sudoku.dart';
import '../common_widgets/app_bar.dart';
import '../common_widgets/play_button.dart';
import '../common_widgets/difficulty_label.dart';
import '../common_widgets/difficulty_slider.dart';
import '../common_widgets/list_text_instruction.dart';
import '../utils/responsive_font_size.dart';
import '../utils/get_difficulty.dart';

class SudokuInstructionPage extends StatefulWidget {
  const SudokuInstructionPage({super.key});

  @override
  State<SudokuInstructionPage> createState() => SudokuInstructionPageState();
}

class SudokuInstructionPageState extends State<SudokuInstructionPage> {
  double _sliderValue = 0.25;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final difficulty = getDifficulty(_sliderValue);

    return Scaffold(
      appBar: CustomAppBar(titleText: "Sudoku"),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF353A3E), Color(0xFF282823)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Isi semua kotak kosong, sehingga setiap baris, kolom, dan kotak 3x3 mengandung semua angka dari 1 hingga 9 tanpa ada pengulangan.',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 25),
                color: Color(0xFFD7C9AE),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(height: responsiveFontSize(screenWidth, 30)),

            Text(
              'Cara Bermain :',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 20),
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),

            SizedBox(height: responsiveFontSize(screenWidth, 20)),

            ListTextInstruction(
              texts: [
                'Pilih kotak kosong pada papan Sudoku.',
                'Pilih angka 1 sampai 9 dari tombol angka di bawah papan untuk mengisi kotak yang dipilih',
                'Jika angka yang dimasukkan salah, akan kehilangan satu hati (nyawa). Hati berwarna merah menunjukkan sisa nyawa.',
              ],
              icon: Icons.check_circle,
              screenWidth: screenWidth,
            ),

            SizedBox(height: responsiveFontSize(screenWidth, 30)),

            // Label tingkat kesulitan
            DifficultyLabel(
              text: difficulty['label'],
              fontSize: responsiveFontSize(screenWidth, 28),
              color: difficulty['color'],
            ),

            SizedBox(height: responsiveFontSize(screenWidth, 12)),

            // Slider tingkat kesulitan
            DifficultySlider(
              difficulty: difficulty,
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
              fontSize: responsiveFontSize(screenWidth, 16),
            ),

            const Spacer(),

            // Tombol PLAY
            PlayButton(
              difficulty: {
                'color': difficulty['color'],
                'level': difficulty['level'],
              },
              showLevelText: false,
              page: SudokuPage(difficultyLevel: difficulty['level']), // Navigasi ke SudokuPage
            ),
          ],
        ),
      ),
    );
  }
}
