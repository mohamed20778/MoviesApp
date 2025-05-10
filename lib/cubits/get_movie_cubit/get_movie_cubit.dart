import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/services/cached_service.dart';
import 'package:movies_app/core/services/movie_service.dart';
import 'package:movies_app/models/movie_model.dart';

part 'get_movie_state.dart';

class GetMovieCubit extends Cubit<GetMovieState> {
  final MovieService movieService;
  final CachedService cachedService;

  GetMovieCubit({required this.movieService, required this.cachedService})
    : super(GetMovieInitial());

  Future<void> getMovies() async {
    try {
      emit(GetMovieLoading());

      // First try to show cached data
      final cachedMovies = CachedService.getCachedMovies();
      if (cachedMovies.isNotEmpty) {
        emit(GetMovieSuccess(movieListState: cachedMovies));
      }

      // Then fetch fresh data
      final freshMovies = await movieService.movieService();

      if (freshMovies.isNotEmpty) {
        emit(GetMovieSuccess(movieListState: freshMovies));
      } else if (cachedMovies.isNotEmpty) {
        // If fresh data is empty but we have cached data, keep showing cached
        emit(GetMovieSuccess(movieListState: cachedMovies));
      } else {
        // Both fresh and cached data are empty
        emit(GetMovieFailure(errmessage: "No movies available"));
      }
    } catch (e) {
      // Fallback to cached data if available
      final cachedMovies = CachedService.getCachedMovies();
      if (cachedMovies.isNotEmpty) {
        emit(GetMovieSuccess(movieListState: cachedMovies));
      } else {
        emit(GetMovieFailure(errmessage: e.toString()));
      }
    }
  }
}
