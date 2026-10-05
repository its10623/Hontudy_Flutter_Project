import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object json) => switch (json) {
    Timestamp() => json.toDate(),
    String() => DateTime.parse(json),
    _ => throw FormatException('timestamp 형식이 올바르지 않음: $json'),
  };

  @override
  Object toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}
