import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/services/movDetails_service.dart';
import 'package:movies_app/models/movie_model.dart';

part 'get_details_state.dart';

class GetDetailsCubit extends Cubit<GetDetailsState> {
  final MovdetailsService? detailsService;
  GetDetailsCubit({this.detailsService}) : super(GetDetailsInitial());

  Future<void> getDetails(int id) async {
    if (state is GetDetailsLoading) return; // Prevent duplicate loading
    emit(GetDetailsLoading());
    try {
      final movieDetails = await detailsService!.movDetails(id: id);
      emit(GetDetailsSuccess(movieDetails: movieDetails));
    } catch (e) {
      emit(GetDetailsFailure(errmessage: e.toString()));
    }
  }
}
