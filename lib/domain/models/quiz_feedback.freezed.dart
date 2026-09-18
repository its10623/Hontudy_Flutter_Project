// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizFeedback {


/// Create a copy of QuizFeedback
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizFeedbackCopyWith<QuizFeedback> get copyWith => _$QuizFeedbackCopyWithImpl<QuizFeedback>(this as QuizFeedback, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuizFeedback;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizFeedback&&(identical(other.isCorrect, _this.isCorrect) || other.isCorrect == _this.isCorrect)&&(identical(other.feedbackText, _this.feedbackText) || other.feedbackText == _this.feedbackText)&&(identical(other.keyPoint, _this.keyPoint) || other.keyPoint == _this.keyPoint)&&(identical(other.codeSnippet, _this.codeSnippet) || other.codeSnippet == _this.codeSnippet)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}


@override
int get hashCode {
  final _this = this as QuizFeedback;
  return Object.hash(runtimeType,_this.isCorrect,_this.feedbackText,_this.keyPoint,_this.codeSnippet,_this.imageUrl);
}

@override
String toString() {
  final _this = this as QuizFeedback;
  return 'QuizFeedback(isCorrect: ${_this.isCorrect}, feedbackText: ${_this.feedbackText}, keyPoint: ${_this.keyPoint}, codeSnippet: ${_this.codeSnippet}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $QuizFeedbackCopyWith<$Res>  {
  factory $QuizFeedbackCopyWith(QuizFeedback value, $Res Function(QuizFeedback) _then) = _$QuizFeedbackCopyWithImpl;
@useResult
$Res call({
 bool isCorrect, String feedbackText, String? keyPoint, CodeSnippet? codeSnippet, String? imageUrl
});




}
/// @nodoc
class _$QuizFeedbackCopyWithImpl<$Res>
    implements $QuizFeedbackCopyWith<$Res> {
  _$QuizFeedbackCopyWithImpl(this._self, this._then);

  final QuizFeedback _self;
  final $Res Function(QuizFeedback) _then;

/// Create a copy of QuizFeedback
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCorrect = null,Object? feedbackText = null,Object? keyPoint = freezed,Object? codeSnippet = freezed,Object? imageUrl = freezed,}) {
  return _then(QuizFeedback(
isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,feedbackText: null == feedbackText ? _self.feedbackText : feedbackText // ignore: cast_nullable_to_non_nullable
as String,keyPoint: freezed == keyPoint ? _self.keyPoint : keyPoint // ignore: cast_nullable_to_non_nullable
as String?,codeSnippet: freezed == codeSnippet ? _self.codeSnippet : codeSnippet // ignore: cast_nullable_to_non_nullable
as CodeSnippet?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizFeedback].
extension QuizFeedbackPatterns on QuizFeedback {
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
