import 'package:result_dart/result_dart.dart';

Future<ResultDart<S, Exception>> guardAsync<S extends Object>(
  Future<S> Function() action,
) async {
  try {
    return Success(await action());
  } catch (e) {
    return Failure(Exception(e.toString()));
  }
}
