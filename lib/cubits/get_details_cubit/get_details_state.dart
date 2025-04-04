part of 'get_details_cubit.dart';

@immutable
sealed class GetDetailsState {}

final class GetDetailsInitial extends GetDetailsState {}

final class GetDetailsSuccess extends GetDetailsState {
  final MovieModel? movieDetails;
  GetDetailsSuccess({required this.movieDetails});
}

final class GetDetailsLoading extends GetDetailsState {}

final class GetDetailsFailure extends GetDetailsState {
  final String errmessage;
  GetDetailsFailure({required this.errmessage});
}
