import 'package:dio/dio.dart';

import '../../storage/share_pref/shared_preferences_manager.dart';
import '../api_urls.dart';


class DioClient {
  final SharedPref _sharedPref = SharedPref();

  late final Dio dio;

  DioClient({required String baseUrl}) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': "application/json", "Accept": "application/json"},
      validateStatus: (status) => status! < 500,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _sharedPref.getAccessToken();
        if (token.isNotEmpty && !options.path.contains("doclogin")) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        print("on error login");
        if (e.response?.statusCode == 401) {
          // Try refresh token
          // final refreshed = await _refreshAccessToken();
          // if (refreshed) {
          //   final token = await _sharedPref.getAccessToken();
          //   e.requestOptions.headers['Authorization'] = 'Bearer $token';
          //   final retryResponse = await dio.fetch(e.requestOptions);
          //   return handler.resolve(retryResponse);
          // } else {
          //   return handler.reject(e);
          // }
        }
        return handler.next(e);
      },
    ));

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  // Future<bool> _refreshAccessToken() async {
  //   try {
  //     final refreshToken = await _sharedPref.getRefreshToken();
  //     final response = await dio.post(AppUrls.refreshTokenUrl, data: {
  //       "refreshToken": refreshToken,
  //     });
  //
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       await _sharedPref.storeAccessToken(data['accessToken']);
  //       await _sharedPref.storeRefreshToken(data['refreshToken']);
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}