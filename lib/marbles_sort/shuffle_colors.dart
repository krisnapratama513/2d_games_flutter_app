import 'dart:math';

List<List<String>> shuffleColors(int numColors) {
  //jika parameter = 6 (acak salah satu 'red', 'yellow', 'green', 'blue', 'purple')
  // final List<String> colors = ['red', 'yellow', 'green', 'blue', 'purple', "acak salah satu"];
  // final selectedColors = colors.sublist(0, numColors);

  // Daftar warna tetap
  final List<String> baseColors = ['red', 'yellow', 'green', 'blue', 'purple'];
  List<String> selectedColors;

  if (numColors == 6) {
    // Pilih satu warna acak dari baseColors untuk warna keenam
    final random = Random();
    String randomColor = baseColors[random.nextInt(baseColors.length)];

    // Gabungkan 5 warna tetap + 1 warna acak
    selectedColors = List.from(baseColors);
    selectedColors.add(randomColor);
  } else {
    // Ambil numColors warna pertama dari baseColors
    selectedColors = baseColors.sublist(0, numColors);
  }
  // =====
  // Batas perubahan
  // =====

  // Membuat array 2D dengan 5 elemen untuk setiap warna
  List<List<String>> colorArray =
      selectedColors.map((color) => List.filled(5, color)).toList();

  // Flatten array 2D menjadi 1D
  List<String> flattened = colorArray.expand((e) => e).toList();

  // Fisher-Yates shuffle
  final random = Random();
  for (int i = flattened.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    String temp = flattened[i];
    flattened[i] = flattened[j];
    flattened[j] = temp;
  }

  // Membagi kembali menjadi array 2D dengan numColors baris dan 5 kolom
  List<List<String>> reshaped = [];
  for (int i = 0; i < numColors; i++) {
    reshaped.add(flattened.sublist(i * 5, i * 5 + 5));
  }

  // Menambahkan dua baris kosong di akhir (opsional, sesuai kebutuhan UI)
  reshaped.add([]);
  reshaped.add([]);

  return reshaped;
}