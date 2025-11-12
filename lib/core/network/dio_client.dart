import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import '../errors/exceptions.dart';
import '../utils/logger.dart';
import '../utils/connectivity_checker.dart';

class DioClient {
  late final Dio _dio;
  CacheOptions? _cacheOptions;
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://restcountries.com/v3.1/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _setupInterceptors();
    _setupCache();
  }

  Future<void> _setupCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final cacheStore = HiveCacheStore(
        cacheDir.path,
        hiveBoxName: 'countries_cache',
      );

      _cacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      );

      _dio.interceptors.insert(
        0,
        DioCacheInterceptor(options: _cacheOptions!),
      );
    } catch (e) {
      Logger.error('Failed to setup cache: $e');
      _cacheOptions = null;
    }
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger.info('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          Logger.info(
              'Response: ${response.statusCode} ${response.requestOptions.path}');

          if (response.statusCode == 304) {
            Logger.info('Cache hit: 304 Not Modified');
          }

          return handler.next(response);
        },
        onError: (error, handler) {
          Logger.error('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 304) {
        final hasInternet = await _connectivityChecker.hasInternetConnection();
        if (!hasInternet && response.statusCode == 200) {
          Logger.info('Cache served offline: ${response.requestOptions.path}');
        }
      }

      return response;
    } on DioException catch (e) {
      final hasInternetNow = await _connectivityChecker.hasInternetConnection();

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
          'Connection timeout',
          isNoInternet: false,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        if (!hasInternetNow) {
          throw NetworkException(
            'No internet connection and no cached data available',
            isNoInternet: true,
          );
        }
        throw NetworkException(
          'Connection error',
          isNoInternet: false,
        );
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        throw ServerException(
          'Server error: $statusCode',
          statusCode,
        );
      } else {
        if (!hasInternetNow) {
          throw NetworkException(
            'No internet connection and no cached data available',
            isNoInternet: true,
          );
        }
        throw NetworkException(
          e.message ?? 'Network error',
          isNoInternet: false,
        );
      }
    } on NetworkException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Unknown error: $e');
    }
  }

  Dio get dio => _dio;
}
