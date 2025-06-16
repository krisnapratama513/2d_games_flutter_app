import 'package:flutter/material.dart';
import 'common_widgets/app_bar.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage>
    with SingleTickerProviderStateMixin {
  // Board state: 0 = empty, 1 = X, 2 = O
  List<int> _board = List.filled(9, 0);
  int _currentPlayer = 1; // X starts first
  bool _gameOver = false;
  List<int>? _winningLine;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _showPopup = false;

  static const double _borderWidth = 3;

  @override
  void initState() {
    super.initState();

    // Animation untuk efek scale saat pemain menekan kotak
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Reset game ke kondisi awal
  void _resetGame() {
    setState(() {
      _board = List.filled(9, 0);
      _currentPlayer = 1;
      _gameOver = false;
      _winningLine = null;
      _showPopup = false;
    });
  }

  // Fungsi untuk mengeksekusi langkah pemain
  void _playMove(int index) {
    if (_board[index] != 0 || _gameOver) return;

    setState(() {
      _board[index] = _currentPlayer;
      _animationController.forward(from: 0);

      if (_checkWin(_currentPlayer)) {
        _gameOver = true;
        _showPopup = false; // Popup tidak perlu muncul saat game selesai
      } else if (!_board.contains(0)) {
        // Jika semua kotak terisi dan tidak ada pemenang, maka seri
        _gameOver = true;
        _showPopup = false;
      } else {
        // Ganti giliran pemain
        _currentPlayer = _currentPlayer == 1 ? 2 : 1;
        _showTurnPopup();
      }
    });
  }

  // Menampilkan popup "Giliranmu" selama 1.5 detik
  void _showTurnPopup() {
    setState(() {
      _showPopup = true;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showPopup = false;
        });
      }
    });
  }

  // Cek apakah pemain menang
  bool _checkWin(int player) {
    const List<List<int>> winPatterns = [
      [0, 1, 2], // Baris 1
      [3, 4, 5], // Baris 2
      [6, 7, 8], // Baris 3
      [0, 3, 6], // Kolom 1
      [1, 4, 7], // Kolom 2
      [2, 5, 8], // Kolom 3
      [0, 4, 8], // Diagonal utama
      [2, 4, 6], // Diagonal sekunder
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == player &&
          _board[pattern[1]] == player &&
          _board[pattern[2]] == player) {
        _winningLine = pattern;
        return true;
      }
    }
    return false;
  }

  // Membangun widget untuk setiap kotak pada papan
  Widget _buildCell(int index, double cellSize) {
    final int cellValue = _board[index];
    final bool isWinningCell = _winningLine?.contains(index) ?? false;

    String? imagePath;

    if (cellValue == 1) {
      // Player X
      if (isWinningCell) {
        imagePath = 'assets/tic_tac_toe/x_win.png';
      } else {
        imagePath = 'assets/tic_tac_toe/x.png';
      }
    } else if (cellValue == 2) {
      // Player O
      if (isWinningCell) {
        imagePath = 'assets/tic_tac_toe/o_win.png';
      } else {
        imagePath = 'assets/tic_tac_toe/o.png';
      }
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: () => _playMove(index),
        child: Container(
          width: cellSize,
          height: cellSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: _borderWidth),
            color: Colors.white, // Background putih agar gambar terlihat jelas
          ),
          child: imagePath != null
              ? Image.asset(imagePath, fit: BoxFit.fill)
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  // Membangun papan permainan
  Widget _buildBoard(double boardSize) {
    final double cellSize =
        (boardSize - 48) / 3; // 12 padding * 4 (3 jarak + tepi)

    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: Colors.green.shade400, // Background papan putih polos
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => _buildCell(index, cellSize),
      ),
    );
  }

  // Membangun status permainan (giliran, menang, atau seri)
  Widget _buildStatus() {
    String status;
    if (_winningLine != null) {
      status = 'Player ${_currentPlayer == 1 ? 'X' : 'O'} Menang!';
    } else if (_gameOver) {
      status = 'Seri!';
    } else {
      status = 'Giliran Player ${_currentPlayer == 1 ? 'X' : 'O'}';
    }

    return Text(
      status,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFABD1C6),
      ),
    );
  }

  // Widget popup "Giliranmu"
  Widget _buildPopup() {
    if (!_showPopup) return const SizedBox.shrink();

    // Posisi popup: atas untuk O, bawah untuk X
    Alignment alignment = _currentPlayer == 2
        ? Alignment.topCenter
        : Alignment.bottomCenter;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Giliranmu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double boardSize = screenWidth * 0.9;
    if (boardSize > 360) boardSize = 360;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(titleText: 'Tic Tac Toe'),

      body: Container(
        color: Color(0xFF353A3E),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildBoard(boardSize),
                  const SizedBox(height: 24),
                  _buildStatus(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _resetGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Reset Game',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            _buildPopup(),
          ],
        ),
      ),
    );
  }
}
