import 'dart:math';

List<List<int>> generateSudoku() {
  const int size = 9;
  const int boxSize = 3;
  final Random random = Random();
  final List<List<int>> board = List.generate(size, (_) => List.filled(size, 0));

  bool isValid(int row, int col, int num) {
    // Cek baris
    for (int x = 0; x < size; x++) {
      if (board[row][x] == num) return false;
    }

    // Cek kolom
    for (int y = 0; y < size; y++) {
      if (board[y][col] == num) return false;
    }

    // Cek kotak 3x3
    int boxRowStart = (row ~/ boxSize) * boxSize;
    int boxColStart = (col ~/ boxSize) * boxSize;
    for (int r = boxRowStart; r < boxRowStart + boxSize; r++) {
      for (int c = boxColStart; c < boxColStart + boxSize; c++) {
        if (board[r][c] == num) return false;
      }
    }

    return true;
  }

  bool solve() {
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (board[row][col] == 0) {
          List<int> numbers = List.generate(size, (index) => index + 1);
          numbers.shuffle(random);

          for (int num in numbers) {
            if (isValid(row, col, num)) {
              board[row][col] = num;
              if (solve()) {
                return true;
              }
              board[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  // Reset board dan mulai solve
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      board[i][j] = 0;
    }
  }
  solve();
  return board;
}
