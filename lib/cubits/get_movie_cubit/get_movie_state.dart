part of 'get_movie_cubit.dart';

@immutable
sealed class GetMovieState {}

final class GetMovieInitial extends GetMovieState {}

final class GetMovieLoading extends GetMovieState {}

final class GetMovieSuccess extends GetMovieState {
  List<MovieModel>? movieListState;

  GetMovieSuccess({this.movieListState});
}

final class GetMovieFailure extends GetMovieState {
  String? errmessage;

  GetMovieFailure({this.errmessage});
}
