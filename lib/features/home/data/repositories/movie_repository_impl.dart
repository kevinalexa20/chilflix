import 'package:chilflix/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:chilflix/features/home/data/models/movie_details_model.dart';
import 'package:chilflix/features/home/data/models/movie_model.dart';
import 'package:chilflix/features/home/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({required this.movieRemoteDatasource});

  final MovieRemoteDatasource movieRemoteDatasource;
  // final MovieLocalDatasource movieLocalDatasource;

  @override
  Future<List<MovieModel>> getMovieBySearch(String query) {
    return movieRemoteDatasource.getMovieBySearch(query);
  }

  @override
  Future<MovieDetailsModel> getMovieDetailsByImdbId(String imdbId) {
    return movieRemoteDatasource.getMovieDetailsByImdbId(imdbId);
  }

  @override
  Future<List<MovieModel>> getNewestMovies(String query) {
    return movieRemoteDatasource.getNewestMovies(query);
  }
}
