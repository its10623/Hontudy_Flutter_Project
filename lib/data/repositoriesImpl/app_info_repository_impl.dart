import 'package:hontudy/data/result_guard.dart';
import 'package:hontudy/domain/repositories/app_info_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../services/local/app_info_service.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final AppInfoService _appInfo;

  AppInfoRepositoryImpl({required this._appInfo});

  @override
  AsyncResult<String> fetchAppVersion() async {
    return guardAsync(() async {
      final appVersion = await _appInfo.fetchAppVersion();

      return appVersion.version;
    });
  }
}
