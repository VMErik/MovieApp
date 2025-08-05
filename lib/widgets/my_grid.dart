import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/models/movie_container.dart';

class MyMovieGrid extends StatelessWidget {
  final List<Movie> movies;
  const MyMovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2, // 2 columnas
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: movies.length,
      shrinkWrap: true,
      // physics:
      //     NeverScrollableScrollPhysics(), // Para usar dentro de un Scroll
      itemBuilder: (context, index) {
        final movie = movies[index];
        final double cardHeight = (index % 3 == 0) ? 250 : 180;

        return GestureDetector(
          onTap: () {
            MovieContainer movieContainer = MovieContainer(
              movie: movie,
              idHero: movie.title.trim() + movie.id.toString(),
            );
            context.push('/movie', extra: movieContainer);
          },
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(movie.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(8),
              child: SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
