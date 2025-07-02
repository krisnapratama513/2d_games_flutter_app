import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import './../common_widgets/app_bar.dart';

// Halaman utama game yang bersifat stateful karena ada perubahan state (posisi ular, skor, dll)
class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

class _SnakeGamePageState extends State<SnakeGamePage> {
  // Ukuran grid permainan (20x20)
  static const int gridSize = 20;

  // Posisi ular, dimulai dengan satu titik di tengah grid
  List<Point<int>> snake = [Point(11, 10)];

  // Posisi makanan
  late Point<int> food;

  // Arah gerak ular, default ke kanan
  String direction = 'right';

  // Timer untuk menggerakkan ular secara periodik
  Timer? gameTimer;

  // Kecepatan gerak ular dalam milidetik (semakin kecil semakin cepat)
  int speed = 200;
  // int speed = 30;

  // Status apakah game sudah dimulai
  bool gameStarted = false;

  // Skor pemain
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateFood(); // Buat makanan pertama kali saat game dimulai
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  // Membuat posisi makanan baru secara acak, pastikan tidak bertabrakan dengan ular
  void generateFood() {
    final random = Random();
    while (true) {
      final newFood = Point(random.nextInt(gridSize), random.nextInt(gridSize));
      if (!snake.contains(newFood)) {
        food = newFood;
        break;
      }
    }
  }

  // Memulai game, reset skor, posisi ular, arah, dan mulai timer
  void startGame() {
    if (gameStarted) return; // Jika sudah mulai, jangan mulai lagi
    gameStarted = true;
    score = 0;
    snake = [Point(10, 9)];
    direction = 'right';
    speed = 200;

    // Timer yang memanggil moveSnake setiap interval kecepatan
    gameTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      setState(() {
        moveSnake();
      });
    });
  }

  // Fungsi untuk menggerakkan ular sesuai arah
  void moveSnake() {
    final head = snake.first;
    Point<int> newHead;

    // Tentukan posisi kepala baru berdasarkan arah
    switch (direction) {
      case 'up':
        newHead = Point(head.x, head.y - 1);
        break;
      case 'down':
        newHead = Point(head.x, head.y + 1);
        break;
      case 'left':
        newHead = Point(head.x - 1, head.y);
        break;
      case 'right':
      default:
        newHead = Point(head.x + 1, head.y);
        break;
    }

    // Cek tabrakan dengan dinding
    if (newHead.x < 0 ||
        newHead.x >= gridSize ||
        newHead.y < 0 ||
        newHead.y >= gridSize) {
      resetGame();
      return;
    }

    // Cek tabrakan dengan tubuh sendiri
    if (snake.contains(newHead)) {
      resetGame();
      return;
    }

    // Tambahkan kepala baru ke posisi ular
    snake.insert(0, newHead);

    // Jika makan makanan, tambah skor dan buat makanan baru, serta percepat game
    if (newHead == food) {
      score += 10;
      increaseSpeed();
      generateFood();
    } else {
      // Jika tidak makan, hapus ekor agar panjang ular tetap sama
      snake.removeLast();
    }
  }

  // Fungsi untuk mempercepat game setiap kali makanan dimakan
  void increaseSpeed() {
    if (speed > 50) {
      speed -= 10;
      gameTimer?.cancel();
      gameTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
        setState(() {
          moveSnake();
        });
      });
    }
  }

  // Fungsi untuk mereset game saat game over
  void resetGame() {
    gameTimer?.cancel();
    gameStarted = false;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                snake = [Point(11, 10)];
                direction = 'right';
                score = 0;
                generateFood();
              });
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk mengubah arah gerak ular, mencegah arah berlawanan langsung
  void changeDirection(String newDirection) {
    if ((direction == 'up' && newDirection == 'down') ||
        (direction == 'down' && newDirection == 'up') ||
        (direction == 'left' && newDirection == 'right') ||
        (direction == 'right' && newDirection == 'left')) {
      return; // Tidak boleh balik arah langsung
    }
    direction = newDirection;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Jika pop berhasil, lakukan sesuatu (misal batalkan timer)
          gameTimer?.cancel();
        } else {
          // Jika pop dibatalkan, bisa tampilkan dialog konfirmasi atau logika lain
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF353A3E),
        appBar: CustomAppBar(titleText: "Snake Game"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tampilan skor
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Score: $score',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFabb78a),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Area permainan dengan gesture untuk mengubah arah ular
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy < 0) {
                        changeDirection('up');
                      } else if (details.delta.dy > 0) {
                        changeDirection('down');
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx < 0) {
                        changeDirection('left');
                      } else if (details.delta.dx > 0) {
                        changeDirection('right');
                      }
                    },
                    onTap: () {
                      if (!gameStarted) {
                        startGame();
                      }
                    },
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2.0),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: gridSize,
                                ),
                            itemCount: gridSize * gridSize,
                            itemBuilder: (context, index) {
                              final x = index % gridSize;
                              final y = index ~/ gridSize;
                              final point = Point(x, y);

                              Color color;
                              if (snake.contains(point)) {
                                color = Colors.grey.shade700;
                              } else if (point == food) {
                                color = Colors.grey.shade300;
                              } else {
                                color = Colors.white;
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 0.3,
                                  ),
                                ),
                                child: Center(
                                  child: color == Colors.grey.shade300
                                      ? const Text("🍎")
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Tombol mulai game muncul jika game belum dimulai
                  if (!gameStarted)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: startGame,
                        child: const Text('Start Game'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
