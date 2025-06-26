import 'package:go_router/go_router.dart';
import 'package:moviesapp/models/movie_container.dart';
import 'package:moviesapp/pages/home.dart';
import 'package:moviesapp/pages/movie.dart';

GoRouter routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/movie',
      builder: (context, state) {
        var extra = state.extra as MovieContainer;
        return MoviePage(movie: extra);
      },
    ),
  ],
);
