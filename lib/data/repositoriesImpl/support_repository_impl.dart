import 'package:hontudy/data/result_guard.dart';
import 'package:hontudy/data/services/local/app_info_service.dart';
import 'package:hontudy/data/services/local/device_info_service.dart';
import 'package:hontudy/data/services/local/email_service.dart';
import 'package:hontudy/domain/repositories/support_repository.dart';
import 'package:result_dart/result_dart.dart';

const _supportEmail = 'smoothsm.dev@hontudy.com';
const _subject = '[혼터디] 문의';

class SupportRepositoryImpl implements SupportRepository {
  final EmailService _email;
  final AppInfoService _appInfo;
  final DeviceInfoService _deviceInfo;

  SupportRepositoryImpl({
    required this._email,
    required this._appInfo,
    required this._deviceInfo,
  });

  @override
  AsyncResult<void> sendInquiry() async {
    return guardAsync(() async {
      await _email.sendInquiry(
        recipient: _supportEmail,
        subject: _subject,
        body: await _getEmailBody(),
      );
      return unit;
    });
  }

  Future<String> _getEmailBody() async {
    final appInfo = await _appInfo.fetchAppVersion();
    final deviceInfo = await _deviceInfo.fetchDeviceInfo();

    return [
      '문의 내용을 적어 주세요.',
      '',
      '',
      '',
      '======================',
      '아래 내용을 함께 보내 주세요🤗',
      '앱 정보: ${appInfo.version}+${appInfo.buildNumber}',
      '기기 정보: $deviceInfo',
      '======================',
    ].join('\n');
  }
}
