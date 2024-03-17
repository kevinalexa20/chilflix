import 'package:chilflix/features/home/domain/entities/movie_details_entity.dart';
import 'package:chilflix/features/home/domain/entities/movie_entity.dart';
import 'package:chilflix/features/home/domain/repositories/movie_repository.dart';

class MovieUseCase {
  MovieUseCase({required this.movieRepository});

  final MovieRepository movieRepository;

  Future<List<MovieEntity>> getMovieBySearch(String query) {
    return movieRepository.getMovieBySearch(query);
  }

  Future<MovieDetailsEntity> getMovieDetailsByImdbId(String imdbId) {
    return movieRepository.getMovieDetailsByImdbId(imdbId);
  }
}