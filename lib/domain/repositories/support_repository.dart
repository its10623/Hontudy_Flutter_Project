import 'package:result_dart/result_dart.dart';

abstract class SupportRepository {
  AsyncResult<void> sendInquiry();
}
