import 'package:flutter/material.dart';

class DifficultySlider extends StatelessWidget {
  final Map<String, dynamic> difficulty;
  final double value;
  final ValueChanged<double> onChanged;
  final double fontSize;

  const DifficultySlider({
    super.key,
    required this.difficulty,
    required this.value,
    required this.onChanged,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            value: value,
            min: 0.0,
            max: 1.0,
            divisions: 3,
            onChanged: onChanged,
          ),
        ),
        
        SizedBox(height: 8),

        Center(
          child: Text(
            'Geser untuk mengatur kesulitan',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
