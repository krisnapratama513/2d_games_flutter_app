import 'package:flutter/material.dart';
import 'shuffle_colors.dart';
import 'win_dialog.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int currentLevel = 23;
  List<List<String>> balls = [];

  int? selectedTube;
  bool isBallLifted = false;
  bool isMovingUp = true;

  @override
  void initState() {
    super.initState();
    balls = shuffleColors(getParameterForLevel(currentLevel));
  }

  int getParameterForLevel(int level) {
    if (level == 1) return 2;
    if (level >= 2 && level <= 4) return 3;
    if (level >= 5 && level <= 10) return 4;
    if (level >= 11 && level <= 22) return 5;
    if (level >= 23) return 6;
    return 2; // default fallback
  }

  void handleTap(int index) {
    setState(() {
      if (!isBallLifted) {
        if (balls[index].isNotEmpty) {
          selectedTube = index;
          isBallLifted = true;
          isMovingUp = true;
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Tabung ini kosong!')));
        }
      } else {
        if (index != selectedTube) {
          List<String> fromTube = balls[selectedTube!];
          List<String> toTube = balls[index];

          if (fromTube.isEmpty) {
            isBallLifted = false;
            selectedTube = null;
            return;
          }

          String topColor = fromTube.last;
          List<String> movingBalls = [];

          for (int i = fromTube.length - 1; i >= 0; i--) {
            if (fromTube[i] == topColor) {
              movingBalls.insert(0, fromTube[i]);
            } else {
              break;
            }
          }

          bool canMove = toTube.isEmpty || toTube.last == topColor;

          if (!canMove) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Warna bola harus sama')));
          } else if (toTube.length + movingBalls.length > 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tabung tidak cukup untuk menampung bola!'),
              ),
            );
          } else {
            for (int i = 0; i < movingBalls.length; i++) {
              fromTube.removeLast();
              toTube.add(topColor);
            }

            // Cek kondisi menang setelah pindah bola
            if (checkWinCondition()) {
              WinDialog.show(context, currentLevel, () {
                setState(() {
                  currentLevel++;
                  balls = shuffleColors(getParameterForLevel(currentLevel));
                  selectedTube = null;
                  isBallLifted = false;
                  isMovingUp = true;
                });
              });
            }
          }
        }

        isMovingUp = false;
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            selectedTube = null;
            isBallLifted = false;
          });
        });
      }
    });
  }

  bool checkWinCondition() {
    for (var tube in balls) {
      if (tube.isEmpty) continue;
      String firstColor = tube[0];
      for (var ball in tube) {
        if (ball != firstColor) return false;
      }
      if (tube.length != 5) {
        return false; // Pastikan tabung penuh dengan warna sama
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ballSize = (screenWidth / 10).clamp(40.0, 100.0);
    final tubeWidth = (ballSize * 1.2).clamp(60.0, 120.0);
    final tubeHeight = ballSize * 5.3;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Level $currentLevel',
          style: TextStyle(color: Color(0xFFDCD7C9)),
        ),
        backgroundColor: const Color(0xFF282823),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Wrap(
            spacing: 16,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: List.generate(balls.length, (index) {
              return GestureDetector(
                onTap: () => handleTap(index),
                child: GlassTube(
                  balls: balls[index],
                  isLifted: isBallLifted && selectedTube == index,
                  isMovingUp: isMovingUp,
                  tubeWidth: tubeWidth,
                  tubeHeight: tubeHeight,
                  ballSize: ballSize,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class GlassTube extends StatelessWidget {
  final List<String> balls;
  final bool isLifted;
  final bool isMovingUp;
  final double tubeWidth;
  final double tubeHeight;
  final double ballSize;

  const GlassTube({
    super.key,
    required this.balls,
    required this.isLifted,
    required this.isMovingUp,
    required this.tubeWidth,
    required this.tubeHeight,
    required this.ballSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tubeWidth,
      height: tubeHeight,
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 2),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(tubeWidth)),
        color: Colors.white.withAlpha((0.85 * 255).toInt()),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: balls.asMap().entries.map((entry) {
          int idx = entry.key;
          String color = entry.value;

          double bottomOffset = idx * (ballSize * 0.85);

          Duration duration = isLifted && idx == balls.length - 1
              ? (isMovingUp
                    ? Duration(milliseconds: 180)
                    : Duration(milliseconds: 350))
              : Duration(milliseconds: 300);

          Curve curve = isLifted && idx == balls.length - 1
              ? (isMovingUp ? Curves.easeIn : Curves.easeOut)
              : Curves.linear;

          double animatedBottom = (isLifted && idx == balls.length - 1)
              ? bottomOffset + (isMovingUp ? ballSize * 0.7 : 0)
              : bottomOffset;

          return AnimatedPositioned(
            duration: duration,
            curve: curve,
            bottom: animatedBottom,
            left: (tubeWidth - ballSize) / 2,
            child: Container(
              width: ballSize,
              height: ballSize,
              decoration: BoxDecoration(
                color: _colorFromName(color),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _colorFromName(String name) {
    switch (name) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
