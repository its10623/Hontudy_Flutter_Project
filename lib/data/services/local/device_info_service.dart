import 'package:device_info_plus/device_info_plus.dart';
import 'package:ios_utsname_ext/extension.dart';

class DeviceInfoService {
  final deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> fetchDeviceInfo() async {
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    return switch (deviceInfo) {
      AndroidDeviceInfo(:final manufacturer, :final model, :final version) =>
        '$manufacturer $model (Android ${version.release})',
      IosDeviceInfo(:final utsname, :final systemVersion) =>
        '${utsname.machine.iOSProductName} (iOS $systemVersion)',
      WebBrowserInfo(:final browserName, :final platform) =>
        '${browserName.name} (${platform ?? '알 수 없음'})',
      _ => '알 수 없음',
    };
  }
}
