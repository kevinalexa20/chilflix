import 'package:bloc/bloc.dart';
import 'package:chilflix/features/home/data/repositories/movie_repository_impl.dart';
import 'package:chilflix/features/home/domain/entities/movie_details_entity.dart';
import 'package:chilflix/features/home/domain/usecases/movie_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.movieRepositoryImpl) : super(DetailsInitial());
  // final MovieUseCase movieUseCase;
  final MovieRepositoryImpl movieRepositoryImpl;

  Future<void> getMovieDetailsByImdbId(String imdbId) async {
    try {
      emit(FetchDetailsOnLoading());
      final data = await movieRepositoryImpl.getMovieDetailsByImdbId(imdbId);
      emit(FetchDetailsOnSuccess(data));
    } catch (e) {
      emit(FetchDetailsOnError(e));
    }
  }
}
