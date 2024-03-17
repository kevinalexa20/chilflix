import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalDatasource {
  static const String FAVORITE_MOVIES_KEY = 'favorite_movies';

  Future<List<String>> getFavoriteMovieIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovieIdsString = prefs.getStringList(FAVORITE_MOVIES_KEY);
    return favoriteMovieIdsString ?? []; // Return empty list if not set
  }

  Future<bool> isMovieFavorite(String movieId) async {
    final favoriteMovieIds = await getFavoriteMovieIds();
    return favoriteMovieIds.contains(movieId);
  }

  Future<void> addMovieToFavorites(String movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentFavoriteMovieIds = await getFavoriteMovieIds();
    currentFavoriteMovieIds.add(movieId);
    await prefs.setStringList(FAVORITE_MOVIES_KEY, currentFavoriteMovieIds);
  }

  Future<void> removeMovieFromFavorites(String movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentFavoriteMovieIds = await getFavoriteMovieIds();
    currentFavoriteMovieIds.remove(movieId);
    await prefs.setStringList(FAVORITE_MOVIES_KEY, currentFavoriteMovieIds);
  }
}
