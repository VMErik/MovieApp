import 'package:flutter/material.dart';
import 'package:moviesapp/models/movie_filter.dart';
import 'package:moviesapp/widgets/my_grid.dart';

class FilterMoviesView extends StatelessWidget {
  final MovieFilter filter;
  const FilterMoviesView({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(filter.tag, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: MyMovieGrid(movies: filter.movies),
    );
  }
}
