import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  final String deviceName;
  final String deviceVersion;
  final String appVersion;

  DeviceInfo(this.deviceName, this.deviceVersion, this.appVersion);

  static Future<DeviceInfo> getInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final String deviceName = iosInfo.name ?? "";
      final String deviceVersion =
          "${iosInfo.systemName ?? ""} ${iosInfo.systemVersion ?? ""}";
      final String appVersion = "v${packageInfo.version}";

      return DeviceInfo(deviceName, deviceVersion, appVersion);
    } else {
      final androidInfo = await deviceInfo.androidInfo;
      final String deviceName = "${androidInfo.manufacturer} ${androidInfo.model}";
      final String deviceVersion =
          "Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})";
      final String appVersion = "v${packageInfo.version}";

      return DeviceInfo(deviceName, deviceVersion, appVersion);
    }
  }
}
