import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common_widgets/main_card.dart';
// page instruksi setiap game
import 'marbles_sort/instruction_marbles.dart';
import 'sudoku/instruction_sudoku.dart';
import 'snake/instruction_snake.dart';
import 'tic_tac_toe/instruction_tictac.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mengunci orientasi layar hanya ke portraitUp
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Game 2D",
          style: TextStyle(
            color: Color(0xFFDCD7C9),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF282823),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF353A3E),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomFlexibleCard(
                    title: "MARBLE SORT",
                    borderColor: const Color(0xFFCC4B3B),
                    backgroundColor: const Color(0xFFFF6F61),
                    textColor: const Color(0xFFFFF1E0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MarblesInstructionPage(),
                        ),
                      );
                    },
                  ),

                  CustomFlexibleCard(
                    title: "SUDOKU",
                    borderColor: const Color(0xFF2E86C1),
                    backgroundColor: const Color(0xFF5DADE2),
                    textColor: const Color(0xFFFFF9C4),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SudokuInstructionPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomFlexibleCard(
                    title: "SNAKE GAME",
                    borderColor: const Color(0xFF5499C7),
                    backgroundColor: const Color(0xFF85C1E9),
                    textColor: const Color(0xFF2F4F4F),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SnakeInstructionPage(),
                        ),
                      );
                    },
                  ),

                  CustomFlexibleCard(
                    title: "TIC TAC TOE",
                    borderColor: const Color(0xFF6C3483),
                    backgroundColor: const Color(0xFF8E44AD),
                    textColor: const Color(0xFFFFD700),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TicTacInstructionPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
