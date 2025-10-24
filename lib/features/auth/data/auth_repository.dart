import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:ecdoc/core/network/service/auth_client.dart';
import 'package:ecdoc/core/network/service/network_api_services.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/auth_login/login_request.dart';
import '../../../core/models/auth_login/login_response.dart';
import '../../../core/network/api_urls.dart';
import '../../../core/network/service/dio_client.dart';


class AuthRepository {
  late final AuthClient _apiService;

  AuthRepository() {
    final dio = DioClient(baseUrl: AppUrls.baseUrlForLogin);
    _apiService = AuthClient(dio.dio);
  }

  Future<LoginResponse> doctorLogin(String email, String password, String ipAddress, String deviceDetails) async {
    try {
      debugPrint("the repo of login");
      final pwd = password.isNotEmpty ? md5.convert(utf8.encode(password)).toString() : password;

      final request = LoginRequest(email: email, password: pwd, ipAddress: ipAddress, deviceDetail: deviceDetails);
      final response = await _apiService.doctorLogin(request);

      debugPrint("THE LOGIN REQUEST $request");
      debugPrint("THE LOGIN RESPONSE $response");
      // final res = NetworkApiServices().processResponse(response as Response);
      return response;
    } on DioException catch (e) {
      throw NetworkApiServices().handleDioError(e);
    }
  }
}
