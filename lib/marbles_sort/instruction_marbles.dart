import 'package:flutter/material.dart';
import 'main_marbles.dart'; // Import halaman game marble

class MarblesInstructionPage extends StatefulWidget {
  const MarblesInstructionPage({super.key});

  @override
  State<MarblesInstructionPage> createState() => _MarblesInstructionPageState();
}

class _MarblesInstructionPageState extends State<MarblesInstructionPage> {
  double _sliderValue = 0.25; // Nilai slider dari 0.0 sampai 1.0

  // Fungsi untuk menentukan level dan warna berdasarkan sliderValue
  Map<String, dynamic> getDifficulty(double value) {
    if (value <= 0.111) {
      return {'label': 'MUDAH', 'color': Color(0xFF4CAF50), 'level': 1};
    } else if (value <= 0.375) {
      return {'label': 'SEDANG', 'color': Color(0xFFFF9800), 'level': 5};
    } else if (value <= 0.875) {
      return {'label': 'SULIT', 'color': Color(0xFFF44336), 'level': 11};
    } else {
      return {'label': 'SANGAT SULIT', 'color': Color(0xFF9C27B0), 'level': 23};
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double baseSize) {
      if (screenWidth < 350) {
        return baseSize * 0.7;
      } else if (screenWidth < 500) {
        return baseSize * 0.8;
      } else if (screenWidth < 700) {
        return baseSize;
      } else {
        return baseSize * 1.0;
      }
    }

    final difficulty = getDifficulty(_sliderValue);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MARBLES SORT',
          style: TextStyle(
            color: Color(0xFFDCD7C9),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF282823),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFFDCD7C9), // This changes the back button color
        ),
        elevation: 4,
      ),
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
                fontSize: responsiveFontSize(20),
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            SizedBox(height: responsiveFontSize(30)),
            Text(
              'Anda hanya dapat memindahkan kelereng ke gelas lain yang:',
              style: TextStyle(
                fontSize: responsiveFontSize(22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: responsiveFontSize(20)),
            // List tanpa card, dengan ikon dan teks langsung
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF9C27B0),
                  size: responsiveFontSize(24),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Masih memiliki ruang kosong',
                    style: TextStyle(
                      fontSize: responsiveFontSize(18),
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsiveFontSize(12)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF9C27B0),
                  size: responsiveFontSize(24),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Berisi kelereng dengan warna yang sama',
                    style: TextStyle(
                      fontSize: responsiveFontSize(18),
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: responsiveFontSize(40)),

            // Label tingkat kesulitan
            Center(
              child: Text(
                difficulty['label'],
                style: TextStyle(
                  fontSize: responsiveFontSize(28),
                  fontWeight: FontWeight.bold,
                  color: difficulty['color'],
                  letterSpacing: 1.5,
                ),
              ),
            ),

            SizedBox(height: responsiveFontSize(12)),

            // Slider dengan custom track dan thumb
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 14,
                activeTrackColor: difficulty['color'],
                inactiveTrackColor: Colors.grey.shade800,
                thumbShape: _CustomThumbShape(difficulty['color']),
                overlayColor: difficulty['color'].withOpacity(0.2),
                trackShape: RoundedRectSliderTrackShape(),
              ),
              child: Slider(
                value: _sliderValue,
                min: 0.0,
                max: 1.0,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ),

            SizedBox(height: 8),

            // Teks "Drag to adjust difficulty"
            Center(
              child: Text(
                'Geser untuk mengatur kesulitan',
                style: TextStyle(
                  fontSize: responsiveFontSize(16),
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Spacer(),

            // Tombol PLAY dan tombol tanda tanya
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol PLAY
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
                          MaterialPageRoute(
                            // builder: (context) => const ThirdPage(difficultyLevel: difficulty['level']),
                            builder: (context) =>
                                ThirdPage(difficultyLevel: difficulty['level']),
                            // ${difficulty['level']}
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PLAY',
                            style: TextStyle(
                              fontSize: responsiveFontSize(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            'Level ${difficulty['level']}',
                            style: TextStyle(
                              fontSize: responsiveFontSize(14),
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
            ),
          ],
        ),
      ),
    );
  }
}

// Custom thumb shape untuk slider
class _CustomThumbShape extends SliderComponentShape {
  final Color innerColor;

  _CustomThumbShape(this.innerColor);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(36, 36); // Ukuran lingkaran luar
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter? labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Lingkaran luar putih
    final outerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Lingkaran dalam berwarna sesuai tingkat
    final innerCirclePaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 18, outerCirclePaint);
    canvas.drawCircle(center, 12, innerCirclePaint);
  }
}
