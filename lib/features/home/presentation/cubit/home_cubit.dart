import 'package:bloc/bloc.dart';
import 'package:chilflix/features/home/data/repositories/movie_repository_impl.dart';
import 'package:chilflix/features/home/domain/entities/movie_details_entity.dart';
import 'package:chilflix/features/home/domain/entities/movie_entity.dart';
import 'package:chilflix/features/home/domain/usecases/movie_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.movieRepositoryImpl) : super(HomeInitial());
  final MovieRepositoryImpl movieRepositoryImpl;
  
  // final MovieUseCase movieUseCase;

  Future<void> getMovieBySearch(String query) async {
    try {
      emit(MovieSearchOnLoading());
      final data = await movieRepositoryImpl.getMovieBySearch(query);
      if (data.isNotEmpty) {
        emit(MovieSearchOnSuccess(data));
      } else {
        emit(MovieSearchOnError('No Movies Found \nwith query $query'));
      }
    } catch (e) {
      emit(MovieSearchOnError(e));
    }
  }

  Future<void> getMovieDetailsByImdbId(String imdbId) async {
    try {
      emit(MovieDetailsOnLoading());
      final data = await movieRepositoryImpl.getMovieDetailsByImdbId(imdbId);
      emit(MovieDetailsOnSuccess(data));
    } catch (e) {
      emit(MovieDetailsOnError(e));
    }
  }

  Future<void> getNewestMovies(String query) async {
    try {
      emit(MovieListOnLoading());
      final data = await movieRepositoryImpl.getNewestMovies(query);
      if (data.isNotEmpty) {
        emit(MovieListOnSuccess(data));
      } else {
        emit(MovieListOnError('No Movies Found'));
      }
    } catch (e) {
      emit(MovieListOnError(e));
    }
  }
}
