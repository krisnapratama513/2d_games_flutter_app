import 'package:flutter/material.dart';
import 'main_marbles.dart'; // Import halaman game marble
import '../common_widgets/app_bar.dart';
import '../common_widgets/play_button.dart';
import '../common_widgets/difficulty_label.dart';
import '../common_widgets/difficulty_slider.dart';
import '../common_widgets/list_text_instruction.dart';
import '../utils/responsive_font_size.dart';
import '../utils/get_difficulty.dart';

class MarblesInstructionPage extends StatefulWidget {
  const MarblesInstructionPage({super.key});

  @override
  State<MarblesInstructionPage> createState() => _MarblesInstructionPageState();
}

class _MarblesInstructionPageState extends State<MarblesInstructionPage> {
  double _sliderValue = 0.25; // Nilai slider dari 0.0 sampai 1.0

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final difficulty = getDifficulty(_sliderValue, levelAsString: false);

    return Scaffold(
      appBar: CustomAppBar(titleText: "MARBLES SORT"),

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
              'Pindahkan kelereng antar gelas kaca hingga semua kelereng dalam satu gelas memiliki warna yang sama.',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 25),
                color: Color(0xFFD7C9AE),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(height: responsiveFontSize(screenWidth, 30)),
            Text(
              'Anda hanya dapat memindahkan kelereng ke gelas lain yang:',
              style: TextStyle(
                fontSize: responsiveFontSize(screenWidth, 22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: responsiveFontSize(screenWidth, 20)),

            // List tanpa card, dengan ikon dan teks langsung
            ListTextInstruction(
              texts: ['Masih memiliki ruang kosong', 'Berisi kelereng dengan warna yang sama'],
              icon: Icons.check_circle,
              screenWidth: screenWidth,
            ),

            SizedBox(height: responsiveFontSize(screenWidth, 60)),

            // Label tingkat kesulitan
            DifficultyLabel(
              text: difficulty['label'],
              fontSize: responsiveFontSize(screenWidth, 28),
              color: difficulty['color'],
            ),

            SizedBox(height: responsiveFontSize(screenWidth, 12)),

            // Slider dengan custom track dan thumb
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
              showLevelText: true,
              page: ThirdPage(
                difficultyLevel: difficulty['level'],
              ), // Navigasi ke SudokuPage
            ),
          ],
        ),
      ),
    );
  }
}

