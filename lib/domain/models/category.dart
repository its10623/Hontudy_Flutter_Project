import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  final String main;
  final String topic;
  final String subTopic;

  const Category({
    required this.main,
    required this.topic,
    required this.subTopic,
  });
}
