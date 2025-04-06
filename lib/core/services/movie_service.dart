import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/models/movie_model.dart';

class MovieService {
  final Dio dio;
  List<MovieModel> movieList = [];

  MovieService({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              headers: {
                'Authorization': 'Bearer ${ApiConstants.token}',
                'accept': 'application/json',
              },
            ),
          );

  Future<List<MovieModel>> movieService() async {
    try {
      final response = await dio.get('/movie/popular');
      if (kDebugMode) {
        print("Api Header:${response.headers}");
        print("Api Data:${response.data}");
      }
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];

        for (int i = 0; i < data.length; i++) {
          movieList.add(MovieModel.fromJson(data[i]));
        }
      }
    } on DioException catch (e) {
      throw Exception("Error: ${e.message}");
    }
    return movieList;
  }
}
