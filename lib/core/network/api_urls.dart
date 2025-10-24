class AppUrls {

  static const String baseUrlForLogin = "https://stage.epicare.net:3000/";
  static const String loginUrl = "service/doclogin";
  static const String refreshTokenUrl = "${baseUrlForLogin}service/refresh-token";

  static const String baseUrl = "https://pfm-backend-1gdg.onrender.com";

  static const String verifyOtp = "$baseUrl/customer/verify-login";
  static const String refreshToken = "$baseUrl/customer/refresh-token";
  static const String searchEndpoint = "$baseUrl/customer/search-item";
}
