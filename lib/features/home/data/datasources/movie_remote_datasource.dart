import 'dart:convert';

import 'package:chilflix/common/constants/omdb_constants.dart';
import 'package:chilflix/features/home/data/models/movie_details_model.dart';
import 'package:chilflix/features/home/data/models/movie_model.dart';
import 'package:http/http.dart';

class MovieRemoteDatasource {
  MovieRemoteDatasource(this._httpClient);

  final Client _httpClient;

  Future<List<MovieModel>> getMovieBySearch(String query) async {
    try {
      final result = await _httpClient.get(
        Uri.parse(OmdbConstants.searchMovieEndpoint + query),
      );
      return MovieModel.fromJsonList(
        jsonDecode(result.body) as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieDetailsModel> getMovieDetailsByImdbId(String imdbId) async {
    try {
      final result = await _httpClient.get(
        Uri.parse(OmdbConstants.movieDetailsEndpoint + imdbId),
      );
      return MovieDetailsModel.fromJson(
        jsonDecode(result.body) as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieModel>> getNewestMovies(String query) async {
    try {
      final result = await _httpClient.get(
        Uri.parse(OmdbConstants.newestMoviesEndpoint + query),
      );
      return MovieModel.fromJsonList(
        jsonDecode(result.body) as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
