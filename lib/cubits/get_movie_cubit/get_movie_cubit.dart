import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/services/movie_service.dart';
import 'package:movies_app/models/movie_model.dart';

part 'get_movie_state.dart';

class GetMovieCubit extends Cubit<GetMovieState> {
  final MovieService? movieService;

  GetMovieCubit({this.movieService}) : super(GetMovieInitial());

  Future<void> getMovies() async {
    if (state is GetMovieLoading) return; // Prevent duplicate loading

    emit(GetMovieLoading());
    try {
      final movieList = await MovieService().movieService();
      emit(GetMovieSuccess(movieListState: movieList));
    } catch (e) {
      emit(
        GetMovieFailure(errmessage: e is String ? e : 'Failed to load movies'),
      );
    }
  }
}
