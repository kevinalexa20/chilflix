import 'package:chilflix/features/home/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.title,
    required super.year,
    required super.imdbID,
    required super.type,
    required super.poster,
  });

  factory MovieModel.fromJson(dynamic json) => MovieModel(
        title: json['Title'] as String,
        year: json['Year'] as String,
        imdbID: json['imdbID'] as String,
        type: json['Type'] as String,
        poster: json['Poster'] as String,
      );

  static List<MovieModel> fromJsonList(Map<String, dynamic> json) {
    try {
      final mappedData = json['Search'] as List<dynamic>;
      return mappedData.map(MovieModel.fromJson).toList();
    } catch (err) {
      return [];
    }
  }
}
