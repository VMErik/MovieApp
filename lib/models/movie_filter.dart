import 'package:moviesapp/models/movie.dart';

class MovieFilter {
  final List<Movie> movies;
  final String tag;
  MovieFilter({required this.movies, required this.tag});
}
