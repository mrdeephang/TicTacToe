import 'package:flutter/material.dart';
import 'package:tictactoe/gamepage.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TicTacToeGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}
