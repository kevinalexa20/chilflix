class OmdbConstants {
  static String apikey = 'f123cc8f';
  static String baseURL = 'https://www.omdbapi.com/?apikey=$apikey';
  static String searchMovieEndpoint = '$baseURL&s=';
  static String movieDetailsEndpoint = '$baseURL&plot=short&i=';
  // static String newestMoviesEndpoint = '$baseURL&y=2024';
  static String newestMoviesEndpoint = '$baseURL&s=';
}
