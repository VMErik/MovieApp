class Movie {
  final String title;
  final String imageUrl;
  final String backdrop;
  final double popularity;
  final int id;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.popularity,
    required this.backdrop,
    required this.id,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Funcion para parsear
    double parseVoteAverage(dynamic value) {
      try {
        return double.parse((value as num).toStringAsFixed(1));
      } catch (e) {
        return 0.0;
      }
    }

    return Movie(
      title: json['title'],
      imageUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      popularity: parseVoteAverage(json['vote_average']),
      id: json['id'],
      backdrop: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
    );
  }
}
