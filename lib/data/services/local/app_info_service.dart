import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  Future<({String version, String buildNumber})> fetchAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return (version: packageInfo.version, buildNumber: packageInfo.buildNumber);
  }
}
