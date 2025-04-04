class MovieModel {
  int? id;
  bool? adult;
  String? backdropPath;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  int? runtime;
  double? voteAverage;
  int? voteCount;
  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
  });
  factory MovieModel.fromJson(Map<String, dynamic> data) => MovieModel(
    adult: data["adult"],
    backdropPath: data["backdrop_path"],
    id: data["id"],
    originalLanguage: data["original_language"],
    originalTitle: data["original_title"],
    overview: data["overview"],
    popularity: data["popularity"].toDouble(),
    posterPath: data["poster_path"],
    releaseDate: data["release_date"],
    title: data["title"],
    voteAverage: data["vote_average"].toDouble(),
    voteCount: data["vote_count"],
    runtime: data["runtime"],
  );
}
