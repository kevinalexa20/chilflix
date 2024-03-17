import 'package:chilflix/features/details/presentation/cubit/details_cubit.dart';
import 'package:chilflix/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:chilflix/features/home/data/repositories/movie_repository_impl.dart';
import 'package:chilflix/features/home/domain/repositories/movie_repository.dart';
import 'package:chilflix/features/home/presentation/cubit/home_cubit.dart';
import 'package:http/http.dart';

class DIContainer {
  //core
  // Client get _client => Client()
  //     .setEndpoint(AppWriteConstants.endPoint)
  //     .setProject(AppWriteConstants.projectID)
  //     .setSelfSigned(status: true);

  // Account get _account => Account(_client);

  // Databases get _databases => Databases(_client);

  Client get _client => Client();

  // FlutterSecureStorage get _secureStorage => const FlutterSecureStorage();

  //Datasource local
  // AuthLocalDataSource get _localDatasource =>
  //     AuthLocalDataSource(_secureStorage);
  // Remote Datasoure
  MovieRemoteDatasource get _movieRemoteDatasource =>
      MovieRemoteDatasource(_client);

  //repository
  // AuthRepository get _authRepository =>
  //     AuthRepository(_remoteDatasource, _localDatasource);
  MovieRepositoryImpl get _movieRepositoryImpl =>
      MovieRepositoryImpl(movieRemoteDatasource: _movieRemoteDatasource);

  //bloc
  // AuthBloc get authBloc => AuthBloc(_authRepository);
  HomeCubit get homeCubit => HomeCubit(_movieRepositoryImpl);
  DetailsCubit get detailsCubit => DetailsCubit(_movieRepositoryImpl);
}
