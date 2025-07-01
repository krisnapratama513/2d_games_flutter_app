import 'package:flutter/material.dart';
import 'button.dart';
import 'sudoku.dart';
import 'sudoku_difficulty.dart';
import '../common_widgets/app_bar.dart';

import 'package:audioplayers/audioplayers.dart';

class SudokuPage extends StatefulWidget {
  final String difficultyLevel;
  const SudokuPage({super.key, required this.difficultyLevel});

  @override
  SudokuPageState createState() => SudokuPageState();
}

class SudokuPageState extends State<SudokuPage> {
  late String currentLevel;

  late final AudioPlayer _audioPlayer;

  List<List<int>> jawaban = [];
  List<List<int>> initialBoard = [];

  late List<List<int>> board;
  int lives = 4; // Mulai dengan 4 nyawa

  int? selectedRow;
  int? selectedCol;

  @override
  void initState() {
    super.initState();
    jawaban = generateSudoku();
    currentLevel = widget.difficultyLevel;
    initialBoard = applySudokuDifficulty(jawaban, currentLevel);
    board = List.generate(
      9,
      (i) => List.generate(9, (j) => initialBoard[i][j]),
    );

    _audioPlayer = AudioPlayer();
    _preloadSounds(); // Tambahkan ini
  }

  Future<void> _preloadSounds() async {
    await _audioPlayer.setSource(AssetSource('sounds/win.mp3'));
    await _audioPlayer.setSource(AssetSource('sounds/lose.mp3'));
  }

  void selectCell(int row, int col) {
    if (initialBoard[row][col] != 0) {
      return;
    }
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  void inputNumber(int number) {
    if (selectedRow != null && selectedCol != null) {
      if (initialBoard[selectedRow!][selectedCol!] == 0) {
        setState(() {
          board[selectedRow!][selectedCol!] = number;
          if (number != jawaban[selectedRow!][selectedCol!]) {
            lives--;
            if (lives == 0) {
              _showGameOverDialog();
            }
          } else {
            if (_checkWin()) {
              _showWinDialog();
            }
          }
        });
      }
    }
  }

  bool _checkWin() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board[i][j] != jawaban[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  void _showGameOverDialog() async {
    await _audioPlayer.play(AssetSource('sounds/lose.mp3'));
    if (!mounted) return; // Cek apakah widget masih aktif


    showDialog(
      context: context,
      barrierDismissible:
          false, // agar tidak bisa dismiss dengan klik di luar dialog
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.sentiment_very_dissatisfied,
                size: 60,
                color: Colors.redAccent,
              ),
              const Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const Text(
                'Nyawa habis, Anda kalah!',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: const Text('Coba Lagi', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWinDialog() async {
    await _audioPlayer.play(AssetSource('sounds/win.mp3'));
    if (!mounted) return; // Cek apakah widget masih aktif

    showDialog(
      context: context,
      barrierDismissible: false, // tidak bisa dismiss klik luar
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.emoji_events, size: 60, color: Colors.green),
              const Text(
                'Selamat!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const Text(
                'Anda berhasil menyelesaikan Sudoku!',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: const Text('Main Lagi', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearCell() {
    if (selectedRow != null && selectedCol != null) {
      if (initialBoard[selectedRow!][selectedCol!] == 0) {
        setState(() {
          board[selectedRow!][selectedCol!] = 0;
        });
      }
    }
  }

  void _resetGame() {
    setState(() {
      lives = 4;
      board = List.generate(
        9,
        (i) => List.generate(9, (j) => initialBoard[i][j]),
      );
      selectedRow = null;
      selectedCol = null;
    });
  }

  Border _buildCellBorder(int row, int col) {
    return Border(
      top: BorderSide(width: row % 3 == 0 ? 2 : 0.5, color: Colors.black54),
      left: BorderSide(width: col % 3 == 0 ? 2 : 0.5, color: Colors.black54),
      right: BorderSide(
        width: (col + 1) % 3 == 0 ? 2 : 0.5,
        color: Colors.black54,
      ),
      bottom: BorderSide(
        width: (row + 1) % 3 == 0 ? 2 : 0.5,
        color: Colors.black54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: widget.difficultyLevel.toUpperCase()),
      // AppBar(title: const Text('Sudoku Flutter'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Icon(
                    Icons.favorite,
                    color: index < lives ? Colors.red : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black87),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                          ),
                      itemCount: 81,
                      itemBuilder: (context, index) {
                        int row = index ~/ 9;
                        int col = index % 9;
                        bool isClue = initialBoard[row][col] != 0;

                        // Cek apakah input salah
                        bool isWrongInput = false;
                        if (!isClue && board[row][col] != 0) {
                          if (board[row][col] != jawaban[row][col]) {
                            isWrongInput = true;
                          }
                        }

                        // Cek apakah cell ini adalah cell yang sedang dipilih
                        bool isSelected =
                            (row == selectedRow && col == selectedCol);

                        // Cek apakah cell ini berada di baris, kolom, atau blok yang sama dengan cell yang dipilih
                        bool isHighlighted = false;
                        if (selectedRow != null && selectedCol != null) {
                          if (row == selectedRow || col == selectedCol) {
                            isHighlighted = true;
                          } else {
                            int selectedBlockRow = selectedRow! ~/ 3;
                            int selectedBlockCol = selectedCol! ~/ 3;
                            int currentBlockRow = row ~/ 3;
                            int currentBlockCol = col ~/ 3;
                            if (selectedBlockRow == currentBlockRow &&
                                selectedBlockCol == currentBlockCol) {
                              isHighlighted = true;
                            }
                          }
                        }

                        return GestureDetector(
                          onTap: () => selectCell(row, col),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue[200]
                                  : isWrongInput
                                  ? Colors.red[100]
                                  : isHighlighted
                                  ? Colors.blue[100]
                                  : isClue
                                  ? Colors.green[100]
                                  : Colors.white,
                              border: _buildCellBorder(row, col),
                            ),
                            child: Center(
                              child: Text(
                                board[row][col] == 0
                                    ? ''
                                    : board[row][col].toString(),
                                style: TextStyle(
                                  fontWeight: isClue
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 20,
                                  color: isClue
                                      ? Colors.black
                                      : isWrongInput
                                      ? Colors.red
                                      : Colors.blue[700],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // button
              ButtonWidget(inputNumber: inputNumber),
            ],
          ),
        ),
      ),
    );
  }
}
