import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../api_urls.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppUrls.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Example endpoint for patient list
  // @GET("/patients")
  // Future<List<dynamic>> getPatients();
}