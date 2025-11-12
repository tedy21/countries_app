import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../network/dio_client.dart';
import '../../features/countries/data/datasources/countries_remote_data_source.dart';
import '../../features/countries/data/repositories/countries_repository_impl.dart';
import '../../features/countries/domain/repositories/countries_repository.dart';
import '../../features/favorites/data/datasources/favorite_local_data_source.dart';
import '../../features/favorites/data/datasources/favorite_local_data_source_impl.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _setupExternal();
  _setupNetwork();
  _setupDataSources();
  _setupRepositories();
}

Future<void> _setupExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  await getTemporaryDirectory();
}

void _setupNetwork() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
}

void _setupDataSources() {
  getIt.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerLazySingleton<FavoriteLocalDataSource>(
    () => FavoriteLocalDataSourceImpl(),
  );
}

void _setupRepositories() {
  getIt.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImpl(
      remoteDataSource: getIt<CountriesRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      localDataSource: getIt<FavoriteLocalDataSource>(),
    ),
  );
}
