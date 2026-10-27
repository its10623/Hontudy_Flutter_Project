import 'package:hontudy/data/dto/report_dto.dart';
import 'package:hontudy/data/result_guard.dart';
import 'package:hontudy/data/services/remotes/auth_service.dart';
import 'package:hontudy/domain/models/report.dart';
import 'package:hontudy/domain/repositories/report_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../services/local/app_info_service.dart';
import '../services/remotes/firestore_service.dart';

class ReportRepositoryImpl implements ReportRepository {
  final FirestoreService _firestore;
  final AuthService _auth;
  final AppInfoService _appInfo;

  ReportRepositoryImpl({
    required this._firestore,
    required this._auth,
    required this._appInfo,
  });

  @override
  AsyncResult<void> sendReport(Report report) {
    return guardAsync(() async {
      final appVersion = await _appInfo.fetchAppVersion();
      await _firestore.saveReport(
        ReportMapper.toDto(
          report,
          _auth.requireUid(),
          '${appVersion.version}+${appVersion.buildNumber}',
        ),
      );
      return unit;
    });
  }
}
