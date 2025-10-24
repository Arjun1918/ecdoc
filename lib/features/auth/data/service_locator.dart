import 'package:ecdoc/core/network/api_urls.dart';
import 'package:ecdoc/core/network/service/auth_client.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/service/dio_client.dart';
import 'auth_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Dio client for auth
  getIt.registerLazySingleton(() => DioClient(baseUrl: AppUrls.baseUrlForLogin));

  // Retrofit service
  getIt.registerLazySingleton<AuthClient>(
          () => AuthClient(getIt<DioClient>().dio));

  // Repository
  getIt.registerLazySingleton(() => AuthRepository());
}
