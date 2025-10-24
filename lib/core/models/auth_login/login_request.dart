class LoginRequest {
  final String email;
  final String password;
  final String ipAddress;
  final String deviceDetail;

  LoginRequest({required this.email, required this.password, required this.ipAddress, required this.deviceDetail});

  Map<String, dynamic> toJson() => {
    "username": email,
    "password": password,
    "ip_address": ipAddress,
    "device_details": deviceDetail,
  };
}
