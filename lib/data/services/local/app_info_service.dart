import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  Future<String> fetchAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
