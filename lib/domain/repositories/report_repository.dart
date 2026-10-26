import 'package:hontudy/domain/models/report.dart';
import 'package:result_dart/result_dart.dart';

abstract class ReportRepository {
  AsyncResult<void> report(Report report);
}
