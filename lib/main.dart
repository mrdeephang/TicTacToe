import 'package:flutter/material.dart';

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

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;
  String winner = '';

  void _handleTap(int index) {
    if (board[index] != '' || winner.isNotEmpty) return;

    setState(() {
      board[index] = xTurn ? 'X' : 'O';
      xTurn = !xTurn;
      winner = _checkWinner();
    });

    if (winner.isNotEmpty) {
      _showResultDialog(winner == 'Draw' ? 'It\'s a Draw!' : '$winner Wins!');
    }
  }

  String _checkWinner() {
    List<List<int>> winPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pos in winPositions) {
      String a = board[pos[0]];
      String b = board[pos[1]];
      String c = board[pos[2]];
      if (a != '' && a == b && b == c) {
        return a;
      }
    }

    if (!board.contains('')) return 'Draw';

    return '';
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
      winner = '';
    });
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: board[index] == 'X' ? Colors.blue : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            winner.isEmpty
                ? '${xTurn ? "X" : "O"}\'s Turn'
                : winner == 'Draw'
                ? 'Draw!'
                : '$winner Wins!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 9,
              itemBuilder: (_, index) => _buildGridItem(index),
            ),
          ),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text(
              'Reset Game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ), // Bigger text
              minimumSize: Size(200, 60), // Minimum width and height
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
