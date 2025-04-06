import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/models/movie_model.dart';

class MovdetailsService {
  final Dio dio;

  MovdetailsService({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              headers: {
                'Authorization': "Bearer ${ApiConstants.token}",
                'accept': 'application/json',
              },
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<MovieModel> movDetails({required int id}) async {
    try {
      final response = await dio.get<Map<String, dynamic>>('/movie/$id');

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('API returned null data');
        }

        final movieDetails = MovieModel.fromJson(response.data!);
        if (kDebugMode) {
          print("Api details header: ${response.headers}");
        }

        if (kDebugMode) {
          print("Successfully fetched: ${movieDetails.title}");
        }

        return movieDetails;
      } else {
        throw Exception(
          'Failed to load movie details. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('details Error: ${e.toString()}');
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
