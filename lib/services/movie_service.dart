import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesapp/models/cast.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/models/movie_detail.dart';

class MovieService {
  final String apiKey = '2eeae4bca0a52f6c03206b09e97bddd0';

  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=es-ES&page=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchTopRated() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=es-ES&page=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchNowPlaying() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=es-ES&page=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchUpcoming() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=es-ES&page=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetail> fetchMovieDetail(int id) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=es-ES',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieDetail.fromJson(data);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<CastMember>> getMovieCast(int id) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey&language=es-ES',
    );
    final response = await http.get(url);
    final List results = json.decode(response.body)["cast"];
    return results.map((json) => CastMember.fromJson(json)).toList();
  }
}
