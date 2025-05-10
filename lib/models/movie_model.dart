import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  bool adult;
  @HiveField(2)
  String backdropPath;
  @HiveField(3)
  String originalLanguage;
  @HiveField(4)
  String originalTitle;
  @HiveField(5)
  String overview;
  @HiveField(6)
  double popularity;
  @HiveField(7)
  String posterPath;
  @HiveField(8)
  String releaseDate;
  @HiveField(9)
  String title;
  @HiveField(10)
  int runtime;
  @HiveField(11)
  double voteAverage;
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
