part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class MovieListOnLoading extends HomeState {}

class MovieListOnSuccess extends HomeState {
  MovieListOnSuccess(this.movieList);

  final List<MovieEntity> movieList;
}

class MovieListOnError extends HomeState {
  MovieListOnError(this.message);

  final dynamic message;
}

class MovieSearchOnLoading extends HomeState {}

class MovieSearchOnSuccess extends HomeState {
  MovieSearchOnSuccess(this.movieList);

  final List<MovieEntity> movieList;
}

class MovieSearchOnError extends HomeState {
  MovieSearchOnError(this.message);

  final dynamic message;
}

class MovieDetailsOnLoading extends HomeState {}

class MovieDetailsOnSuccess extends HomeState {
  MovieDetailsOnSuccess(this.movieDetails);

  final MovieDetailsEntity movieDetails;
}

class MovieDetailsOnError extends HomeState {
  MovieDetailsOnError(this.message);

  final dynamic message;
}
