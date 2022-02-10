import 'package:flutter/material.dart';
import 'package:movie_first/model/movie.dart';

class DetailScreen extends StatelessWidget {
  final Results results;
  const DetailScreen({required this.results, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(results.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: Image.network(
            results.posterPath,
            fit: BoxFit.cover,
          )),
          Expanded(child: Text(results.overview)),
        ],
      ),
    );
    ;
  }
}
