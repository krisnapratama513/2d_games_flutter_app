import 'dart:math';

List<List<int>> applySudokuDifficulty(List<List<int>> grid, String level) {
  // Definisikan jumlah sel yang akan dihapus berdasarkan level kesulitan
  final Map<String, int> levels = {
    'mudah': 25,
    'sedang': 35,
    'sulit': 42,
    'sangat sulit': 50,
  };

  if (!levels.containsKey(level)) {
    throw ArgumentError(
        "Level harus salah satu dari: 'mudah', 'sedang', 'sulit', 'sangat sulit'");
  }

  // Buat salinan grid agar input asli tidak berubah (deep copy)
  List<List<int>> newGrid = List.generate(
    9,
    (r) => List<int>.from(grid[r]),
  );

  int countToRemove = levels[level]!;

  // Buat list posisi semua sel (row, col)
  List<List<int>> positions = [];
  for (int r = 0; r < 9; r++) {
    for (int c = 0; c < 9; c++) {
      positions.add([r, c]);
    }
  }

  // Fungsi untuk mengambil sampel acak sebanyak n elemen dari list
  List<List<int>> getRandomSample(List<List<int>> arr, int n) {
    final random = Random();
    List<List<int>> clonedArr = List.from(arr);
    List<List<int>> result = [];

    for (int i = 0; i < n; i++) {
      int idx = random.nextInt(clonedArr.length);
      result.add(clonedArr[idx]);
      clonedArr.removeAt(idx);
    }
    return result;
  }

  // Ambil posisi yang akan dihapus
  List<List<int>> toRemove = getRandomSample(positions, countToRemove);

  // Ganti angka di posisi terpilih menjadi 0
  for (var pos in toRemove) {
    int r = pos[0];
    int c = pos[1];
    newGrid[r][c] = 0;
  }

  return newGrid;
}
