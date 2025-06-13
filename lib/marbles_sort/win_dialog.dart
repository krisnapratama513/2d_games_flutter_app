import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class WinDialog extends StatefulWidget {
  final int currentLevel;
  final VoidCallback onNextLevel;

  const WinDialog({
    super.key,
    required this.currentLevel,
    required this.onNextLevel,
  });

  static Future<void> show(BuildContext context, int currentLevel, VoidCallback onNextLevel) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Level Completed",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return WinDialog(currentLevel: currentLevel, onNextLevel: onNextLevel);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

  @override
  WinDialogState createState() => WinDialogState();
}

class WinDialogState extends State<WinDialog> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _playSound();
  }

  Future<void> _playSound() async {
    // Pastikan widget masih mounted sebelum memutar suara
    if (!mounted) return;
    await _player.play(AssetSource('sounds/sort_mar_win.mp3'));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green.shade600,
                size: 72,
              ),
              SizedBox(height: 16),
              Text(
                'Selamat! 🎉',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Kamu berhasil menyelesaikan level ${widget.currentLevel}!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  if (!mounted) return;
                  Navigator.of(context).pop();
                  widget.onNextLevel();
                },
                child: Text(
                  'Lanjut ke Level ${widget.currentLevel + 1}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
