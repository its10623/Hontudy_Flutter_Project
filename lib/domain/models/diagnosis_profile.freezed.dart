// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagnosisProfile {


/// Create a copy of DiagnosisProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisProfileCopyWith<DiagnosisProfile> get copyWith => _$DiagnosisProfileCopyWithImpl<DiagnosisProfile>(this as DiagnosisProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagnosisProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisProfile&&(identical(other.background, _this.background) || other.background == _this.background)&&(identical(other.difficultyScore, _this.difficultyScore) || other.difficultyScore == _this.difficultyScore)&&const DeepCollectionEquality().equals(other.purposeTags, _this.purposeTags)&&const DeepCollectionEquality().equals(other.weakAreas, _this.weakAreas));
}


@override
int get hashCode {
  final _this = this as DiagnosisProfile;
  return Object.hash(runtimeType,_this.background,_this.difficultyScore,const DeepCollectionEquality().hash(_this.purposeTags),const DeepCollectionEquality().hash(_this.weakAreas));
}

@override
String toString() {
  final _this = this as DiagnosisProfile;
  return 'DiagnosisProfile(background: ${_this.background}, difficultyScore: ${_this.difficultyScore}, purposeTags: ${_this.purposeTags}, weakAreas: ${_this.weakAreas})';
}


}

/// @nodoc
abstract mixin class $DiagnosisProfileCopyWith<$Res>  {
  factory $DiagnosisProfileCopyWith(DiagnosisProfile value, $Res Function(DiagnosisProfile) _then) = _$DiagnosisProfileCopyWithImpl;
@useResult
$Res call({
 String background, int difficultyScore, List<String> purposeTags, List<String> weakAreas
});




}
/// @nodoc
class _$DiagnosisProfileCopyWithImpl<$Res>
    implements $DiagnosisProfileCopyWith<$Res> {
  _$DiagnosisProfileCopyWithImpl(this._self, this._then);

  final DiagnosisProfile _self;
  final $Res Function(DiagnosisProfile) _then;

/// Create a copy of DiagnosisProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? background = null,Object? difficultyScore = null,Object? purposeTags = null,Object? weakAreas = null,}) {
  return _then(DiagnosisProfile(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as String,difficultyScore: null == difficultyScore ? _self.difficultyScore : difficultyScore // ignore: cast_nullable_to_non_nullable
as int,purposeTags: null == purposeTags ? _self.purposeTags : purposeTags // ignore: cast_nullable_to_non_nullable
as List<String>,weakAreas: null == weakAreas ? _self.weakAreas : weakAreas // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisProfile].
extension DiagnosisProfilePatterns on DiagnosisProfile {
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

/// @nodoc
mixin _$DiagnosisResult {


/// Create a copy of DiagnosisResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisResultCopyWith<DiagnosisResult> get copyWith => _$DiagnosisResultCopyWithImpl<DiagnosisResult>(this as DiagnosisResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagnosisResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisResult&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&(identical(other.backgroundDetail, _this.backgroundDetail) || other.backgroundDetail == _this.backgroundDetail)&&(identical(other.reasoning, _this.reasoning) || other.reasoning == _this.reasoning)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence));
}


@override
int get hashCode {
  final _this = this as DiagnosisResult;
  return Object.hash(runtimeType,_this.profile,_this.backgroundDetail,_this.reasoning,_this.confidence);
}

@override
String toString() {
  final _this = this as DiagnosisResult;
  return 'DiagnosisResult(profile: ${_this.profile}, backgroundDetail: ${_this.backgroundDetail}, reasoning: ${_this.reasoning}, confidence: ${_this.confidence})';
}


}

/// @nodoc
abstract mixin class $DiagnosisResultCopyWith<$Res>  {
  factory $DiagnosisResultCopyWith(DiagnosisResult value, $Res Function(DiagnosisResult) _then) = _$DiagnosisResultCopyWithImpl;
@useResult
$Res call({
 DiagnosisProfile profile, String? backgroundDetail, String reasoning, int confidence
});




}
/// @nodoc
class _$DiagnosisResultCopyWithImpl<$Res>
    implements $DiagnosisResultCopyWith<$Res> {
  _$DiagnosisResultCopyWithImpl(this._self, this._then);

  final DiagnosisResult _self;
  final $Res Function(DiagnosisResult) _then;

/// Create a copy of DiagnosisResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? backgroundDetail = freezed,Object? reasoning = null,Object? confidence = null,}) {
  return _then(DiagnosisResult(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DiagnosisProfile,backgroundDetail: freezed == backgroundDetail ? _self.backgroundDetail : backgroundDetail // ignore: cast_nullable_to_non_nullable
as String?,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisResult].
extension DiagnosisResultPatterns on DiagnosisResult {
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
