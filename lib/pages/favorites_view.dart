import 'package:flutter/material.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/services/movie_service.dart';
import 'package:moviesapp/widgets/my_grid.dart';

class FavoritesViewPage extends StatefulWidget {
  const FavoritesViewPage({super.key});

  @override
  State<FavoritesViewPage> createState() => _FavoritesViewPageState();
}

class _FavoritesViewPageState extends State<FavoritesViewPage> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _popularMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _popularMovies = _movieService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    // Lo pasamos a un futre,por que esperara que se llene
    return FutureBuilder<List<Movie>>(
      future: _popularMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mostramos que esta cargando
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay películas disponibles'));
        }

        final movies = snapshot.data!;
        return MyMovieGrid(movies: movies);
      },
    );
  }
}
