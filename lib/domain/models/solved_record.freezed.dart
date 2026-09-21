// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solved_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SolvedRecord {


/// Create a copy of SolvedRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolvedRecordCopyWith<SolvedRecord> get copyWith => _$SolvedRecordCopyWithImpl<SolvedRecord>(this as SolvedRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SolvedRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolvedRecord&&(identical(other.quiz, _this.quiz) || other.quiz == _this.quiz)&&(identical(other.userAnswer, _this.userAnswer) || other.userAnswer == _this.userAnswer)&&(identical(other.quizFeedback, _this.quizFeedback) || other.quizFeedback == _this.quizFeedback)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}


@override
int get hashCode {
  final _this = this as SolvedRecord;
  return Object.hash(runtimeType,_this.quiz,_this.userAnswer,_this.quizFeedback,_this.timestamp);
}

@override
String toString() {
  final _this = this as SolvedRecord;
  return 'SolvedRecord(quiz: ${_this.quiz}, userAnswer: ${_this.userAnswer}, quizFeedback: ${_this.quizFeedback}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $SolvedRecordCopyWith<$Res>  {
  factory $SolvedRecordCopyWith(SolvedRecord value, $Res Function(SolvedRecord) _then) = _$SolvedRecordCopyWithImpl;
@useResult
$Res call({
 Quiz quiz, String userAnswer, DateTime timestamp, QuizFeedback quizFeedback
});




}
/// @nodoc
class _$SolvedRecordCopyWithImpl<$Res>
    implements $SolvedRecordCopyWith<$Res> {
  _$SolvedRecordCopyWithImpl(this._self, this._then);

  final SolvedRecord _self;
  final $Res Function(SolvedRecord) _then;

/// Create a copy of SolvedRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quiz = null,Object? userAnswer = null,Object? timestamp = null,Object? quizFeedback = null,}) {
  return _then(SolvedRecord(
quiz: null == quiz ? _self.quiz : quiz // ignore: cast_nullable_to_non_nullable
as Quiz,userAnswer: null == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,quizFeedback: null == quizFeedback ? _self.quizFeedback : quizFeedback // ignore: cast_nullable_to_non_nullable
as QuizFeedback,
  ));
}

}


/// Adds pattern-matching-related methods to [SolvedRecord].
extension SolvedRecordPatterns on SolvedRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
