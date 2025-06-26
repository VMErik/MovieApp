class MovieDetail {
  final String backdropPath;
  final String posterPath;
  final int id;
  final int runtime;
  final String title;
  final String tagline;
  final String overview;
  final double popularity;

  MovieDetail({
    required this.backdropPath,
    required this.posterPath,
    required this.id,
    required this.runtime,
    required this.title,
    required this.tagline,
    required this.overview,
    required this.popularity,
  });

  /// Método factory para crear el objeto desde JSON
  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    // Funcion para parsear
    double parseVoteAverage(dynamic value) {
      try {
        return double.parse((value as num).toStringAsFixed(1));
      } catch (e) {
        return 0.0;
      }
    }

    return MovieDetail(
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      id: json['id'],
      runtime: json['runtime'] ?? 0,
      title: json['title'] ?? '',
      tagline: json['tagline'] ?? '',
      overview: json['overview'] ?? '',
      popularity: parseVoteAverage(json['vote_average']),
    );
  }

  /// Formatea la duración en horas y minutos, ej: "2h 55m"
  String get formattedRuntime {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return '${hours}h ${minutes}m';
  }

  /// URLs completas de imagen si las necesitas
  String get fullBackdropUrl => 'https://image.tmdb.org/t/p/w500$backdropPath';
  String get fullPosterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
}
