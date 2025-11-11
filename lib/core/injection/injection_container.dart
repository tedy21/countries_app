import '../network/dio_client.dart';
import '../../features/countries/data/datasources/countries_remote_data_source.dart';
import '../../features/countries/data/repositories/countries_repository_impl.dart';
import '../../features/countries/domain/repositories/countries_repository.dart';
import '../../features/favorites/data/datasources/favorite_local_data_source_impl.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  late final DioClient dioClient;
  late final CountriesRemoteDataSource remoteDataSource;
  late final CountriesRepository countriesRepository;
  late final FavoriteLocalDataSourceImpl favoriteLocalDataSource;
  late final FavoritesRepository favoritesRepository;

  Future<void> init() async {
    dioClient = DioClient();
    remoteDataSource = CountriesRemoteDataSourceImpl(dioClient: dioClient);
    countriesRepository =
        CountriesRepositoryImpl(remoteDataSource: remoteDataSource);
    favoriteLocalDataSource = FavoriteLocalDataSourceImpl();
    favoritesRepository =
        FavoritesRepositoryImpl(localDataSource: favoriteLocalDataSource);
  }
}
