import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class DeviceHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceDetails() async {
    try {
      if (kIsWeb) {
        return '';
      }

      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        // var infos = '${info.manufacturer} ${info.model} (Android ${info.version.release})';
        return info.name;
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        // var infos = '${info.name} ${info.model} (iOS ${info.systemVersion})';
        return info.name;
      }
      // else if (Platform.isMacOS) {
      //   final info = await _deviceInfo.macOsInfo;
      //   return 'macOS ${info.model} ${info.osRelease}';
      // } else if (Platform.isWindows) {
      //   final info = await _deviceInfo.windowsInfo;
      //   return 'Windows ${info.computerName}';
      // } else if (Platform.isLinux) {
      //   final info = await _deviceInfo.linuxInfo;
      //   return info.prettyName ?? info.name ?? 'Linux';
      // }
      else {
        return 'unknown';
      }
    } catch (e) {
      return 'unknown';
    }
  }

  /// Gets public IP using a simple public IP service (works for client public IP)
  static Future<String> getIpAddress() async {
    try {
      // Using http package for brevity; you can use Dio similarly
      // final res = await Uri.parse('https://api.ipify.org?format=json')
      //     .readAsString(); // only available if dart:io supports it
      // For this snippet we parse the string:
      // final ip = RegExp(r'"ip"\s*:\s*"([^"]+)"').firstMatch(res)?.group(1);
      // return ip ?? '';

      // If using http package:
      final r = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      final json = jsonDecode(r.body);
      return json['ip'];

    } catch (e) {
      // Fallback: local loopback (not public)
      return '0.0.0.0';
    }
  }
}
