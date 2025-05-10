import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/core/utils/functions/save_Movie.dart';
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
        print("Api movies Header:${response.headers}");
      }
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];

        for (int i = 0; i < data.length; i++) {
          movieList.add(MovieModel.fromJson(data[i]));
        }
        saveBoxData(movieList, ApiConstants.kmovieBox);
        if (kDebugMode) {
          print("Successfully fetched: ${movieList.length}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error of movies Service: ${e.toString()}");
      }
    }
    return movieList;
  }
}
