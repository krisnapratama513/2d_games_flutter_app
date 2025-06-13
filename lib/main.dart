import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'marbles_sort/instruction_marbles.dart';
import 'tic_tac_toe.dart';
import 'sudoku/main_sudoku.dart';
import 'snake.dart';

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
        title: Text("Game 2D", style: TextStyle(color: Color(0xFFDCD7C9), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF282823),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF353A3E),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MarblesInstructionPage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFCC4B3B),
                            width: 4.0,
                          ),
                          color: Color(0xFFFF6F61),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "MARBLE SORT",
                                style: TextStyle(
                                  color: Color(0xFFFFF1E0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Color(0xFFFFF1E0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SudokuPage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF2E86C1),
                            width: 4.0,
                          ),
                          color: Color(0xFF5DADE2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "SUDOKU",
                                style: TextStyle(
                                  color: Color(0xFFFFF9C4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Color(0xFFFFF9C4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SnakeGamePage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF5499C7),
                            width: 4.0,
                          ),
                          color: Color(0xFF85C1E9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "ULAR NOKIA",
                                style: TextStyle(
                                  color: Color(0xFF2F4F4F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Color(0xFF2F4F4F),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TicTacToePage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF6C3483),
                            width: 4.0,
                          ),
                          color: Color(0xFF8E44AD),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "TIC TAC TOE",
                                style: TextStyle(
                                  color: Color(0xFFFFD700),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Color(0xFFFFD700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
