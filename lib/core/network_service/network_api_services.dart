import 'dart:convert';
import 'dart:io';

import 'package:ecdoc/core/exception/app_exceptions.dart';
import 'package:ecdoc/core/network_service/base_api_services.dart';
import 'package:ecdoc/core/storage/shared_preferences_manager.dart';
import 'package:ecdoc/constants/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class NetworkApiServices extends BaseApiServices {
  final SharedPref _sharedPref = SharedPref();

  

  Future<void> _refreshAccessToken() async {
    final refreshToken = await _sharedPref.getRefreshToken();
    final response = await http.post(
      Uri.parse(AppUrls.refreshToken),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['data']['accessToken'];
      final newRefreshToken = data['data']['refreshToken'];

      await _sharedPref.storeAccessToken(newAccessToken);
      await _sharedPref.storeRefreshToken(newRefreshToken);
    } else {
      throw UnauthorizedException("Unable to refresh token");
    }
  }

  @override
  Future<dynamic> getApiResponse(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    int retryCount = 0,
  }) async {
    try {
      String token = await _sharedPref.getAccessToken();
      final Map<String, String> finalHeaders = {
        'Authorization': 'Bearer $token',
        ...?headers,
      };
      final response = await http.get(Uri.parse(url), headers: finalHeaders);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on UnauthorizedException {
      if (retryCount < 1) {
        await _refreshAccessToken();
        return getApiResponse(
          url,
          headers: headers,
          body: body,
          retryCount: retryCount + 1,
        );
      } else {
        rethrow;
      }
    }
  }

  @override
Future<dynamic> postApiResponse(
  String url,
  dynamic data, {
  Map<String, String>? headers,
  int retryCount = 0,
}) async {
  try {
    String token = await _sharedPref.getAccessToken();

    final Map<String, String> finalHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: finalHeaders,
      body: data != null ? jsonEncode(data) : null,
    );

    return _processResponse(response);
  } on SocketException {
    throw FetchDataException("No Internet connection");
  } on UnauthorizedException {
    if (retryCount < 1) {
      await _refreshAccessToken();
      return postApiResponse(
        url,
        data,
        headers: headers,
        retryCount: retryCount + 1,
      );
    } else {
      rethrow;
    }
  } catch (e) {
    rethrow;
  }
}

  Future<dynamic> putApiResponse(
  String url,
  dynamic data, {
  Map<String, String>? headers,
  int retryCount = 0,
}) async {
  try {
    String token = await _sharedPref.getAccessToken();
    final Map<String, String> finalHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    final response = await http.put(
      Uri.parse(url),
      headers: finalHeaders,
      body: data != null ? jsonEncode(data) : null,
    );

    return _processResponse(response);
  } on SocketException {
    throw FetchDataException("No Internet connection");
  } on UnauthorizedException {
    if (retryCount < 1) {
      await _refreshAccessToken();
      return putApiResponse(
        url,
        data,
        headers: headers,
        retryCount: retryCount + 1,
      );
    } else {
      rethrow;
    }
  } catch (e) {
    rethrow;
  }
}
Future<dynamic> patchApiResponse(
  String url,
  dynamic data, {
  Map<String, String>? headers,
  int retryCount = 0,
}) async {
  try {
    String token = await _sharedPref.getAccessToken();
    final Map<String, String> finalHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    final response = await http.patch(
      Uri.parse(url),
      headers: finalHeaders,
      body: data != null ? jsonEncode(data) : null,
    );

    return _processResponse(response);
  } on SocketException {
    throw FetchDataException("No Internet connection");
  } on UnauthorizedException {
    if (retryCount < 1) {
      await _refreshAccessToken();
      return patchApiResponse(
        url,
        data,
        headers: headers,
        retryCount: retryCount + 1,
      );
    } else {
      rethrow;
    }
  } catch (e) {
    rethrow;
  }
}

  Future<dynamic> deleteApiResponse(
  String url, {
  Map<String, String>? headers,
  dynamic data,
  int retryCount = 0,
}) async {
  try {
    String token = await _sharedPref.getAccessToken();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    final response = await http.delete(
      Uri.parse(url),
      headers: requestHeaders,
      body: data != null ? jsonEncode(data) : null,
    );

    return _processResponse(response);
  } on SocketException {
    throw FetchDataException("No Internet connection");
  } on UnauthorizedException {
    if (retryCount < 1) {
      await _refreshAccessToken();
      return deleteApiResponse(
        url,
        headers: headers,
        data: data,
        retryCount: retryCount + 1,
      );
    } else {
      rethrow;
    }
  }
}
  dynamic _processResponse(http.Response response) {
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.isNotEmpty ? jsonDecode(response.body) : response;
      case 404:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with server. Status code: ${response.statusCode}',
        );
    }
  }
}
