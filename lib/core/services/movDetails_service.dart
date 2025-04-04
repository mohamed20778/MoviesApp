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
              connectTimeout: const Duration(seconds: 10), // Added timeout
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<MovieModel> movDetails({required int id}) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/movie/$id',
      ); // Specify response type

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('API Response: ${response.data}');
        }

        if (response.data == null) {
          throw Exception('API returned null data');
        }

        final movieDetails = MovieModel.fromJson(response.data!);

        if (kDebugMode) {
          print("Successfully fetched: ${movieDetails.title}");
        }

        return movieDetails;
      } else {
        throw Exception(
          'Failed to load movie details. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Dio Error: ${e.message}\n${e.stackTrace}');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Unexpected Error: $e\n$stackTrace');
      }
      throw Exception('Failed to load movie details: $e');
    }
  }
}
