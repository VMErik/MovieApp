import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/models/movie_container.dart';
import 'package:moviesapp/models/movie_filter.dart';
import 'package:moviesapp/services/movie_service.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _topRatedMovies;
  late Future<List<Movie>> _upcomingMovies;
  late Future<List<Movie>> _nowplayingMovies;

  @override
  void initState() {
    super.initState();
    _popularMovies = _movieService.fetchPopularMovies();
    _topRatedMovies = _movieService.fetchTopRated();
    _upcomingMovies = _movieService.fetchUpcoming();
    _nowplayingMovies = _movieService.fetchNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _movieCard('Now Playing', _nowplayingMovies),
            SizedBox(height: 20),
            _movieCard('Popular Movies', _popularMovies),
            SizedBox(height: 20),
            _movieCard('Top Rated', _topRatedMovies),
            SizedBox(height: 20),
            _movieCard('Upcoming', _upcomingMovies),
          ],
        ),
      ),
    );
  }

  Widget _movieCard(String title, Future<List<Movie>> moviesFuture) {
    return FutureBuilder<List<Movie>>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(child: Text('Error no data available'));
        }

        final movies = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    MovieFilter movieContainer = MovieFilter(
                      tag: title,
                      movies: movies,
                    );
                    context.push('/filter', extra: movieContainer);
                  },
                  child: Row(
                    children: [
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 20),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return SizedBox(
                    width: 150, // Ancho fijo para cada tarjeta
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            MovieContainer movieContainer = MovieContainer(
                              movie: movie,
                              idHero: title.trim() + movie.id.toString(),
                            );
                            context.push('/movie', extra: movieContainer);
                          },
                          child: Hero(
                            tag: title.trim() + movie.id.toString(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                movie.imageUrl,
                                width: 150,
                                height: 180,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 150,
                                      height: 180,
                                      color: Colors.grey[800],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 20),
                              Icon(Icons.star, color: Colors.amber, size: 12),
                              Text(
                                movie.popularity.toString(),
                                style: TextStyle(color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
