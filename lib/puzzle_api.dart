import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'puzzle.dart';

class PuzzleApi {
  static Future<Puzzle> fetchPuzzle() async {
    var url = 'https://sugoku.herokuapp.com/board?difficulty=easy';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Puzzle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load puzzle');
    }
  }
}
