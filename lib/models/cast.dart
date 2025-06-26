class CastMember {
  final String name;
  final String character;
  final String profilePath;

  CastMember({
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }

  String get fullProfileUrl => profilePath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w200$profilePath'
      : '';
}
