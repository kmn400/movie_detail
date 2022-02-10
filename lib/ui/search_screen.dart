import 'package:flutter/material.dart';
import 'package:movie_first/data/movie_api.dart';
import 'package:movie_first/model/movie.dart';
import 'package:movie_first/ui/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Results> _movies = [];

  final _api = MovieApi();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future<void> _show(String query) async {
      List<Results> movies = await _api.fetchMovies(query);
      setState(() {
        _movies = movies;
      });
    }

    _show('');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    List<Results> movies = await _api.fetchMovies(query);
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화 정보 검색기'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _showResult(_textEditingController.text);
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 1,
                    children: _movies
                        .map((e) => InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(results: e)));
                            },
                            child: Image.network(e.posterPath)))
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
