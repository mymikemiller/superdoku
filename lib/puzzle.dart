class Puzzle {
  final List<int> board;

  Puzzle({this.board});

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    // json['board'] is an array of arrays. Translate into a linear list of 81 numbers.
    List<int> board = [];
    var jsonBoard = json['board'];
    jsonBoard.forEach((row) {
      for (int num in row) {
        board.add(num);
      }
    });
    return Puzzle(board: board);
  }
}
