import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/auth_login/login_request.dart';
import '../../models/auth_login/login_response.dart';
import '../api_urls.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: AppUrls.baseUrlForLogin)
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST(AppUrls.loginUrl)
  Future<LoginResponse> doctorLogin(@Body() LoginRequest request);
}
