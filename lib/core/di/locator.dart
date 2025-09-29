import 'package:get_it/get_it.dart';
import '../../constants/api_constants.dart';
import '../../features/crypto_list/data/datasource/coin_remote_data_source.dart';
import '../../features/crypto_list/data/datasource/coin_remote_data_source_impl.dart';
import '../../features/crypto_list/data/repositories/coin_repository_impl.dart';
import '../../features/crypto_list/domain/repositories/coin_repository.dart';
import '../../features/crypto_list/domain/usecases/get_coins_use_case.dart';
import '../../features/crypto_list/domain/usecases/search_coins_use_case.dart';
import '../network/dio_client.dart';
import '../network/http_clients.dart';

final locator = GetIt.instance;

class ServiceLocator {

  static Future<void> setup() async {
    await _setupNetwork();
    await _setupDataSources();
    await _setupRepositories();
    await _setupUseCases();
  }

  static Future<void> _setupNetwork() async {
    locator.registerLazySingleton<HttpClients>(
          () => DioHttpClient(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      ),
    );
  }

  static Future<void> _setupDataSources() async {
    locator.registerLazySingleton<CoinRemoteDataSource>(
          () => CoinRemoteDataSourceImpl(httpClients: locator<HttpClients>()),
    );
  }

  static Future<void> _setupRepositories() async{
    locator.registerLazySingleton<CoinRepository>(
          () => CoinRepositoryImpl(remoteDataSource: locator<CoinRemoteDataSource>()),
    );
  }

  static Future<void> _setupUseCases() async{
    locator.registerLazySingleton<GetCoinsUseCase>(
          () => GetCoinsUseCase(locator<CoinRepository>()),
    );
    locator.registerLazySingleton<SearchCoinsUseCase>(
          () => SearchCoinsUseCase(locator<CoinRepository>()),
    );
  }


}
