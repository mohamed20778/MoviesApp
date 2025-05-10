import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  bool? adult;
  @HiveField(2)
  String? backdropPath;
  @HiveField(3)
  String? originalLanguage;
  @HiveField(4)
  String? originalTitle;
  @HiveField(5)
  String? overview;
  @HiveField(6)
  double? popularity;
  @HiveField(7)
  String? posterPath;
  @HiveField(8)
  String? releaseDate;
  @HiveField(9)
  String? title;
  @HiveField(10)
  int? runtime;
  @HiveField(11)
  double? voteAverage;
  @HiveField(12)
  int voteCount;
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
    adult: data["adult"] as bool? ?? false,
    backdropPath: data["backdrop_path"] as String?,
    id: data["id"] as int?,
    originalLanguage: data["original_language"] as String?,
    originalTitle: data["original_title"] as String?,
    overview: data["overview"] as String?,
    popularity: (data["popularity"] as num?)?.toDouble() ?? 0.0,
    posterPath: data["poster_path"] as String?,
    releaseDate: data["release_date"] as String?,
    title: data["title"] as String?,
    voteAverage: (data["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: data["vote_count"] as int? ?? 0,
    runtime: data["runtime"] as int? ?? 0, // Handle null runtime
  );
}
