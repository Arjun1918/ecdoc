import 'package:dio/dio.dart';
import '../../../utils/app_exceptions.dart';

class NetworkApiServices {

  dynamic processResponse(Response response) {
    if (response.data == null) return null;

    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.data.toString());
      case 404:
        throw BadRequestException("Not Found: ${response.data}");
      case 500:
      default:
        throw FetchDataException(
          "Server Error: ${response.statusCode} ${response.statusMessage}",
        );
    }
  }

  Exception handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return FetchDataException("No Internet Connection");
    } else if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return BadRequestException(e.response!.data.toString());
        case 401:
          return UnauthorizedException(e.response!.data.toString());
        case 403:
          return UnauthorizedException(e.response!.data.toString());
        case 500:
          return FetchDataException("Internal Server Error");
        default:
          return FetchDataException(
              "Unexpected error: ${e.response?.statusCode}");
      }
    } else {
      return FetchDataException("Unknown error: ${e.message}");
    }
  }
}
