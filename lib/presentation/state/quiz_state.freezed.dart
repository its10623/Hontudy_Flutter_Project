// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizState {


/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizStateCopyWith<QuizState> get copyWith => _$QuizStateCopyWithImpl<QuizState>(this as QuizState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuizState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizState&&(identical(other.quiz, _this.quiz) || other.quiz == _this.quiz)&&(identical(other.userAnswer, _this.userAnswer) || other.userAnswer == _this.userAnswer)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.phase, _this.phase) || other.phase == _this.phase));
}


@override
int get hashCode {
  final _this = this as QuizState;
  return Object.hash(runtimeType,_this.quiz,_this.userAnswer,_this.feedback,_this.phase);
}

@override
String toString() {
  final _this = this as QuizState;
  return 'QuizState(quiz: ${_this.quiz}, userAnswer: ${_this.userAnswer}, feedback: ${_this.feedback}, phase: ${_this.phase})';
}


}

/// @nodoc
abstract mixin class $QuizStateCopyWith<$Res>  {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) _then) = _$QuizStateCopyWithImpl;
@useResult
$Res call({
 Quiz? quiz, String? userAnswer, QuizFeedback? feedback, QuizPhase phase
});




}
/// @nodoc
class _$QuizStateCopyWithImpl<$Res>
    implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._self, this._then);

  final QuizState _self;
  final $Res Function(QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quiz = freezed,Object? userAnswer = freezed,Object? feedback = freezed,Object? phase = null,}) {
  return _then(QuizState(
quiz: freezed == quiz ? _self.quiz : quiz // ignore: cast_nullable_to_non_nullable
as Quiz?,userAnswer: freezed == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as QuizFeedback?,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as QuizPhase,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizState].
extension QuizStatePatterns on QuizState {
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
mixin _$QuizPhase {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizPhase);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase()';
}


}

/// @nodoc
class $QuizPhaseCopyWith<$Res>  {
$QuizPhaseCopyWith(QuizPhase _, $Res Function(QuizPhase) __);
}


/// Adds pattern-matching-related methods to [QuizPhase].
extension QuizPhasePatterns on QuizPhase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Idle value)?  idle,TResult Function( Answering value)?  answering,TResult Function( LoadingQuiz value)?  loadingQuiz,TResult Function( Grading value)?  grading,TResult Function( Graded value)?  graded,TResult Function( QuizFailed value)?  quizFailed,TResult Function( ReviewMode value)?  reviewMode,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle(_that);case Answering() when answering != null:
return answering(_that);case LoadingQuiz() when loadingQuiz != null:
return loadingQuiz(_that);case Grading() when grading != null:
return grading(_that);case Graded() when graded != null:
return graded(_that);case QuizFailed() when quizFailed != null:
return quizFailed(_that);case ReviewMode() when reviewMode != null:
return reviewMode(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Idle value)  idle,required TResult Function( Answering value)  answering,required TResult Function( LoadingQuiz value)  loadingQuiz,required TResult Function( Grading value)  grading,required TResult Function( Graded value)  graded,required TResult Function( QuizFailed value)  quizFailed,required TResult Function( ReviewMode value)  reviewMode,}){
final _that = this;
switch (_that) {
case Idle():
return idle(_that);case Answering():
return answering(_that);case LoadingQuiz():
return loadingQuiz(_that);case Grading():
return grading(_that);case Graded():
return graded(_that);case QuizFailed():
return quizFailed(_that);case ReviewMode():
return reviewMode(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Idle value)?  idle,TResult? Function( Answering value)?  answering,TResult? Function( LoadingQuiz value)?  loadingQuiz,TResult? Function( Grading value)?  grading,TResult? Function( Graded value)?  graded,TResult? Function( QuizFailed value)?  quizFailed,TResult? Function( ReviewMode value)?  reviewMode,}){
final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle(_that);case Answering() when answering != null:
return answering(_that);case LoadingQuiz() when loadingQuiz != null:
return loadingQuiz(_that);case Grading() when grading != null:
return grading(_that);case Graded() when graded != null:
return graded(_that);case QuizFailed() when quizFailed != null:
return quizFailed(_that);case ReviewMode() when reviewMode != null:
return reviewMode(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  answering,TResult Function()?  loadingQuiz,TResult Function()?  grading,TResult Function()?  graded,TResult Function( Object error,  QuizRetryTarget retryTarget)?  quizFailed,TResult Function()?  reviewMode,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle();case Answering() when answering != null:
return answering();case LoadingQuiz() when loadingQuiz != null:
return loadingQuiz();case Grading() when grading != null:
return grading();case Graded() when graded != null:
return graded();case QuizFailed() when quizFailed != null:
return quizFailed(_that.error,_that.retryTarget);case ReviewMode() when reviewMode != null:
return reviewMode();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  answering,required TResult Function()  loadingQuiz,required TResult Function()  grading,required TResult Function()  graded,required TResult Function( Object error,  QuizRetryTarget retryTarget)  quizFailed,required TResult Function()  reviewMode,}) {final _that = this;
switch (_that) {
case Idle():
return idle();case Answering():
return answering();case LoadingQuiz():
return loadingQuiz();case Grading():
return grading();case Graded():
return graded();case QuizFailed():
return quizFailed(_that.error,_that.retryTarget);case ReviewMode():
return reviewMode();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  answering,TResult? Function()?  loadingQuiz,TResult? Function()?  grading,TResult? Function()?  graded,TResult? Function( Object error,  QuizRetryTarget retryTarget)?  quizFailed,TResult? Function()?  reviewMode,}) {final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle();case Answering() when answering != null:
return answering();case LoadingQuiz() when loadingQuiz != null:
return loadingQuiz();case Grading() when grading != null:
return grading();case Graded() when graded != null:
return graded();case QuizFailed() when quizFailed != null:
return quizFailed(_that.error,_that.retryTarget);case ReviewMode() when reviewMode != null:
return reviewMode();case _:
  return null;

}
}

}

/// @nodoc


class Idle extends QuizPhase {
  const Idle(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase.idle()';
}


}




/// @nodoc


class Answering extends QuizPhase {
  const Answering(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Answering);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase.answering()';
}


}




/// @nodoc


class LoadingQuiz extends QuizPhase {
  const LoadingQuiz(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingQuiz);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase.loadingQuiz()';
}


}




/// @nodoc


class Grading extends QuizPhase {
  const Grading(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Grading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase.grading()';
}


}




/// @nodoc


class Graded extends QuizPhase {
  const Graded(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Graded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase.graded()';
}


}




/// @nodoc


class QuizFailed extends QuizPhase {
  const QuizFailed({required this.error, required this.retryTarget}): super._();
  

 final  Object error;
 final  QuizRetryTarget retryTarget;

/// Create a copy of QuizPhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizFailedCopyWith<QuizFailed> get copyWith => _$QuizFailedCopyWithImpl<QuizFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizFailed&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.retryTarget, retryTarget) || other.retryTarget == retryTarget));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(error),retryTarget);
}

@override
String toString() {
    return 'QuizPhase.quizFailed(error: $error, retryTarget: $retryTarget)';
}


}

/// @nodoc
abstract mixin class $QuizFailedCopyWith<$Res> implements $QuizPhaseCopyWith<$Res> {
  factory $QuizFailedCopyWith(QuizFailed value, $Res Function(QuizFailed) _then) = _$QuizFailedCopyWithImpl;
@useResult
$Res call({
 Object error, QuizRetryTarget retryTarget
});




}
/// @nodoc
class _$QuizFailedCopyWithImpl<$Res>
    implements $QuizFailedCopyWith<$Res> {
  _$QuizFailedCopyWithImpl(this._self, this._then);

  final QuizFailed _self;
  final $Res Function(QuizFailed) _then;

/// Create a copy of QuizPhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? retryTarget = null,}) {
  return _then(QuizFailed(
error: null == error ? _self.error : error ,retryTarget: null == retryTarget ? _self.retryTarget : retryTarget // ignore: cast_nullable_to_non_nullable
as QuizRetryTarget,
  ));
}


}

/// @nodoc


class ReviewMode extends QuizPhase {
  const ReviewMode(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewMode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizPhase.reviewMode()';
}


}




// dart format on
