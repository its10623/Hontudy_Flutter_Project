// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagnosisState {


/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisStateCopyWith<DiagnosisState> get copyWith => _$DiagnosisStateCopyWithImpl<DiagnosisState>(this as DiagnosisState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagnosisState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisState&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.phase, _this.phase) || other.phase == _this.phase));
}


@override
int get hashCode {
  final _this = this as DiagnosisState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.messages),_this.phase);
}

@override
String toString() {
  final _this = this as DiagnosisState;
  return 'DiagnosisState(messages: ${_this.messages}, phase: ${_this.phase})';
}


}

/// @nodoc
abstract mixin class $DiagnosisStateCopyWith<$Res>  {
  factory $DiagnosisStateCopyWith(DiagnosisState value, $Res Function(DiagnosisState) _then) = _$DiagnosisStateCopyWithImpl;
@useResult
$Res call({
 List<DiagnosisMessage> messages, DiagnosisPhase phase
});




}
/// @nodoc
class _$DiagnosisStateCopyWithImpl<$Res>
    implements $DiagnosisStateCopyWith<$Res> {
  _$DiagnosisStateCopyWithImpl(this._self, this._then);

  final DiagnosisState _self;
  final $Res Function(DiagnosisState) _then;

/// Create a copy of DiagnosisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? phase = null,}) {
  return _then(DiagnosisState(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<DiagnosisMessage>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as DiagnosisPhase,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisState].
extension DiagnosisStatePatterns on DiagnosisState {
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
mixin _$DiagnosisMessage {

 String get id; DateTime get createdAt;
/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisMessageCopyWith<DiagnosisMessage> get copyWith => _$DiagnosisMessageCopyWithImpl<DiagnosisMessage>(this as DiagnosisMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagnosisMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as DiagnosisMessage;
  return Object.hash(runtimeType,_this.id,_this.createdAt);
}

@override
String toString() {
  final _this = this as DiagnosisMessage;
  return 'DiagnosisMessage(id: ${_this.id}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $DiagnosisMessageCopyWith<$Res>  {
  factory $DiagnosisMessageCopyWith(DiagnosisMessage value, $Res Function(DiagnosisMessage) _then) = _$DiagnosisMessageCopyWithImpl;
@useResult
$Res call({
 String id, DateTime createdAt
});




}
/// @nodoc
class _$DiagnosisMessageCopyWithImpl<$Res>
    implements $DiagnosisMessageCopyWith<$Res> {
  _$DiagnosisMessageCopyWithImpl(this._self, this._then);

  final DiagnosisMessage _self;
  final $Res Function(DiagnosisMessage) _then;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisMessage].
extension DiagnosisMessagePatterns on DiagnosisMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AiQuestion value)?  aiQuestion,TResult Function( UserAnswer value)?  userAnswer,TResult Function( AiSummary value)?  aiSummary,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AiQuestion() when aiQuestion != null:
return aiQuestion(_that);case UserAnswer() when userAnswer != null:
return userAnswer(_that);case AiSummary() when aiSummary != null:
return aiSummary(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AiQuestion value)  aiQuestion,required TResult Function( UserAnswer value)  userAnswer,required TResult Function( AiSummary value)  aiSummary,}){
final _that = this;
switch (_that) {
case AiQuestion():
return aiQuestion(_that);case UserAnswer():
return userAnswer(_that);case AiSummary():
return aiSummary(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AiQuestion value)?  aiQuestion,TResult? Function( UserAnswer value)?  userAnswer,TResult? Function( AiSummary value)?  aiSummary,}){
final _that = this;
switch (_that) {
case AiQuestion() when aiQuestion != null:
return aiQuestion(_that);case UserAnswer() when userAnswer != null:
return userAnswer(_that);case AiSummary() when aiSummary != null:
return aiSummary(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  DateTime createdAt,  String questionText,  DiagnosisContent content)?  aiQuestion,TResult Function( String id,  DateTime createdAt,  String text)?  userAnswer,TResult Function( String id,  DateTime createdAt,  DiagnosisResult result)?  aiSummary,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AiQuestion() when aiQuestion != null:
return aiQuestion(_that.id,_that.createdAt,_that.questionText,_that.content);case UserAnswer() when userAnswer != null:
return userAnswer(_that.id,_that.createdAt,_that.text);case AiSummary() when aiSummary != null:
return aiSummary(_that.id,_that.createdAt,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  DateTime createdAt,  String questionText,  DiagnosisContent content)  aiQuestion,required TResult Function( String id,  DateTime createdAt,  String text)  userAnswer,required TResult Function( String id,  DateTime createdAt,  DiagnosisResult result)  aiSummary,}) {final _that = this;
switch (_that) {
case AiQuestion():
return aiQuestion(_that.id,_that.createdAt,_that.questionText,_that.content);case UserAnswer():
return userAnswer(_that.id,_that.createdAt,_that.text);case AiSummary():
return aiSummary(_that.id,_that.createdAt,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  DateTime createdAt,  String questionText,  DiagnosisContent content)?  aiQuestion,TResult? Function( String id,  DateTime createdAt,  String text)?  userAnswer,TResult? Function( String id,  DateTime createdAt,  DiagnosisResult result)?  aiSummary,}) {final _that = this;
switch (_that) {
case AiQuestion() when aiQuestion != null:
return aiQuestion(_that.id,_that.createdAt,_that.questionText,_that.content);case UserAnswer() when userAnswer != null:
return userAnswer(_that.id,_that.createdAt,_that.text);case AiSummary() when aiSummary != null:
return aiSummary(_that.id,_that.createdAt,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class AiQuestion extends DiagnosisMessage {
  const AiQuestion({required this.id, required this.createdAt, required this.questionText, required this.content}): super._();
  

@override final  String id;
@override final  DateTime createdAt;
 final  String questionText;
 final  DiagnosisContent content;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiQuestionCopyWith<AiQuestion> get copyWith => _$AiQuestionCopyWithImpl<AiQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AiQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,questionText,content);
}

@override
String toString() {
    return 'DiagnosisMessage.aiQuestion(id: $id, createdAt: $createdAt, questionText: $questionText, content: $content)';
}


}

/// @nodoc
abstract mixin class $AiQuestionCopyWith<$Res> implements $DiagnosisMessageCopyWith<$Res> {
  factory $AiQuestionCopyWith(AiQuestion value, $Res Function(AiQuestion) _then) = _$AiQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, String questionText, DiagnosisContent content
});


$DiagnosisContentCopyWith<$Res> get content;

}
/// @nodoc
class _$AiQuestionCopyWithImpl<$Res>
    implements $AiQuestionCopyWith<$Res> {
  _$AiQuestionCopyWithImpl(this._self, this._then);

  final AiQuestion _self;
  final $Res Function(AiQuestion) _then;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? questionText = null,Object? content = null,}) {
  return _then(AiQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as DiagnosisContent,
  ));
}

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagnosisContentCopyWith<$Res> get content {
  
  return $DiagnosisContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}

/// @nodoc


class UserAnswer extends DiagnosisMessage {
  const UserAnswer({required this.id, required this.createdAt, required this.text}): super._();
  

@override final  String id;
@override final  DateTime createdAt;
 final  String text;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAnswerCopyWith<UserAnswer> get copyWith => _$UserAnswerCopyWithImpl<UserAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,text);
}

@override
String toString() {
    return 'DiagnosisMessage.userAnswer(id: $id, createdAt: $createdAt, text: $text)';
}


}

/// @nodoc
abstract mixin class $UserAnswerCopyWith<$Res> implements $DiagnosisMessageCopyWith<$Res> {
  factory $UserAnswerCopyWith(UserAnswer value, $Res Function(UserAnswer) _then) = _$UserAnswerCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, String text
});




}
/// @nodoc
class _$UserAnswerCopyWithImpl<$Res>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._self, this._then);

  final UserAnswer _self;
  final $Res Function(UserAnswer) _then;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? text = null,}) {
  return _then(UserAnswer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AiSummary extends DiagnosisMessage {
  const AiSummary({required this.id, required this.createdAt, required this.result}): super._();
  

@override final  String id;
@override final  DateTime createdAt;
 final  DiagnosisResult result;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiSummaryCopyWith<AiSummary> get copyWith => _$AiSummaryCopyWithImpl<AiSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AiSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,result);
}

@override
String toString() {
    return 'DiagnosisMessage.aiSummary(id: $id, createdAt: $createdAt, result: $result)';
}


}

/// @nodoc
abstract mixin class $AiSummaryCopyWith<$Res> implements $DiagnosisMessageCopyWith<$Res> {
  factory $AiSummaryCopyWith(AiSummary value, $Res Function(AiSummary) _then) = _$AiSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, DiagnosisResult result
});


$DiagnosisResultCopyWith<$Res> get result;

}
/// @nodoc
class _$AiSummaryCopyWithImpl<$Res>
    implements $AiSummaryCopyWith<$Res> {
  _$AiSummaryCopyWithImpl(this._self, this._then);

  final AiSummary _self;
  final $Res Function(AiSummary) _then;

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? result = null,}) {
  return _then(AiSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as DiagnosisResult,
  ));
}

/// Create a copy of DiagnosisMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagnosisResultCopyWith<$Res> get result {
  
  return $DiagnosisResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc
mixin _$DiagnosisPhase {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisPhase);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisPhase()';
}


}

/// @nodoc
class $DiagnosisPhaseCopyWith<$Res>  {
$DiagnosisPhaseCopyWith(DiagnosisPhase _, $Res Function(DiagnosisPhase) __);
}


/// Adds pattern-matching-related methods to [DiagnosisPhase].
extension DiagnosisPhasePatterns on DiagnosisPhase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WaitingAnswer value)?  waitingAnswer,TResult Function( Sending value)?  sending,TResult Function( Classifying value)?  classifying,TResult Function( Confirming value)?  confirming,TResult Function( Failed value)?  failed,TResult Function( Completed value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WaitingAnswer() when waitingAnswer != null:
return waitingAnswer(_that);case Sending() when sending != null:
return sending(_that);case Classifying() when classifying != null:
return classifying(_that);case Confirming() when confirming != null:
return confirming(_that);case Failed() when failed != null:
return failed(_that);case Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WaitingAnswer value)  waitingAnswer,required TResult Function( Sending value)  sending,required TResult Function( Classifying value)  classifying,required TResult Function( Confirming value)  confirming,required TResult Function( Failed value)  failed,required TResult Function( Completed value)  completed,}){
final _that = this;
switch (_that) {
case WaitingAnswer():
return waitingAnswer(_that);case Sending():
return sending(_that);case Classifying():
return classifying(_that);case Confirming():
return confirming(_that);case Failed():
return failed(_that);case Completed():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WaitingAnswer value)?  waitingAnswer,TResult? Function( Sending value)?  sending,TResult? Function( Classifying value)?  classifying,TResult? Function( Confirming value)?  confirming,TResult? Function( Failed value)?  failed,TResult? Function( Completed value)?  completed,}){
final _that = this;
switch (_that) {
case WaitingAnswer() when waitingAnswer != null:
return waitingAnswer(_that);case Sending() when sending != null:
return sending(_that);case Classifying() when classifying != null:
return classifying(_that);case Confirming() when confirming != null:
return confirming(_that);case Failed() when failed != null:
return failed(_that);case Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  waitingAnswer,TResult Function()?  sending,TResult Function()?  classifying,TResult Function()?  confirming,TResult Function( Object error,  DiagnosisRetryTarget retryTarget)?  failed,TResult Function( DiagnosisProfile profile)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WaitingAnswer() when waitingAnswer != null:
return waitingAnswer();case Sending() when sending != null:
return sending();case Classifying() when classifying != null:
return classifying();case Confirming() when confirming != null:
return confirming();case Failed() when failed != null:
return failed(_that.error,_that.retryTarget);case Completed() when completed != null:
return completed(_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  waitingAnswer,required TResult Function()  sending,required TResult Function()  classifying,required TResult Function()  confirming,required TResult Function( Object error,  DiagnosisRetryTarget retryTarget)  failed,required TResult Function( DiagnosisProfile profile)  completed,}) {final _that = this;
switch (_that) {
case WaitingAnswer():
return waitingAnswer();case Sending():
return sending();case Classifying():
return classifying();case Confirming():
return confirming();case Failed():
return failed(_that.error,_that.retryTarget);case Completed():
return completed(_that.profile);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  waitingAnswer,TResult? Function()?  sending,TResult? Function()?  classifying,TResult? Function()?  confirming,TResult? Function( Object error,  DiagnosisRetryTarget retryTarget)?  failed,TResult? Function( DiagnosisProfile profile)?  completed,}) {final _that = this;
switch (_that) {
case WaitingAnswer() when waitingAnswer != null:
return waitingAnswer();case Sending() when sending != null:
return sending();case Classifying() when classifying != null:
return classifying();case Confirming() when confirming != null:
return confirming();case Failed() when failed != null:
return failed(_that.error,_that.retryTarget);case Completed() when completed != null:
return completed(_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class WaitingAnswer extends DiagnosisPhase {
  const WaitingAnswer(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitingAnswer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisPhase.waitingAnswer()';
}


}




/// @nodoc


class Sending extends DiagnosisPhase {
  const Sending(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Sending);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisPhase.sending()';
}


}




/// @nodoc


class Classifying extends DiagnosisPhase {
  const Classifying(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Classifying);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisPhase.classifying()';
}


}




/// @nodoc


class Confirming extends DiagnosisPhase {
  const Confirming(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Confirming);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisPhase.confirming()';
}


}




/// @nodoc


class Failed extends DiagnosisPhase {
  const Failed({required this.error, required this.retryTarget}): super._();
  

 final  Object error;
 final  DiagnosisRetryTarget retryTarget;

/// Create a copy of DiagnosisPhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailedCopyWith<Failed> get copyWith => _$FailedCopyWithImpl<Failed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Failed&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.retryTarget, retryTarget) || other.retryTarget == retryTarget));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(error),retryTarget);
}

@override
String toString() {
    return 'DiagnosisPhase.failed(error: $error, retryTarget: $retryTarget)';
}


}

/// @nodoc
abstract mixin class $FailedCopyWith<$Res> implements $DiagnosisPhaseCopyWith<$Res> {
  factory $FailedCopyWith(Failed value, $Res Function(Failed) _then) = _$FailedCopyWithImpl;
@useResult
$Res call({
 Object error, DiagnosisRetryTarget retryTarget
});




}
/// @nodoc
class _$FailedCopyWithImpl<$Res>
    implements $FailedCopyWith<$Res> {
  _$FailedCopyWithImpl(this._self, this._then);

  final Failed _self;
  final $Res Function(Failed) _then;

/// Create a copy of DiagnosisPhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? retryTarget = null,}) {
  return _then(Failed(
error: null == error ? _self.error : error ,retryTarget: null == retryTarget ? _self.retryTarget : retryTarget // ignore: cast_nullable_to_non_nullable
as DiagnosisRetryTarget,
  ));
}


}

/// @nodoc


class Completed extends DiagnosisPhase {
  const Completed({required this.profile}): super._();
  

 final  DiagnosisProfile profile;

/// Create a copy of DiagnosisPhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletedCopyWith<Completed> get copyWith => _$CompletedCopyWithImpl<Completed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Completed&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profile);
}

@override
String toString() {
    return 'DiagnosisPhase.completed(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $CompletedCopyWith<$Res> implements $DiagnosisPhaseCopyWith<$Res> {
  factory $CompletedCopyWith(Completed value, $Res Function(Completed) _then) = _$CompletedCopyWithImpl;
@useResult
$Res call({
 DiagnosisProfile profile
});


$DiagnosisProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$CompletedCopyWithImpl<$Res>
    implements $CompletedCopyWith<$Res> {
  _$CompletedCopyWithImpl(this._self, this._then);

  final Completed _self;
  final $Res Function(Completed) _then;

/// Create a copy of DiagnosisPhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(Completed(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DiagnosisProfile,
  ));
}

/// Create a copy of DiagnosisPhase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagnosisProfileCopyWith<$Res> get profile {
  
  return $DiagnosisProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
