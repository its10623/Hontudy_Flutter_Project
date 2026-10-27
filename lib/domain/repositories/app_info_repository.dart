
import 'package:result_dart/result_dart.dart';

abstract class AppInfoRepository {
  AsyncResult<String> fetchAppVersion();
}