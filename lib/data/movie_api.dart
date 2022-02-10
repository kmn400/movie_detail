import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_first/model/movie.dart';

class MovieApi {
  Future<List<Results>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1'));
    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['results'];
      return jsonList.map((e) => Results.fromJson(e)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }

  Future<List<Results>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=a64533e7ece6c72731da47c9c8bc691f&query=$query&language=ko-KR&page=1'));
    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['results'];
      return jsonList.map((e) => Results.fromJson(e)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }
}
