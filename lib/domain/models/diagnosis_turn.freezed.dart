// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_turn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagnosisTurn {


/// Create a copy of DiagnosisTurn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisTurnCopyWith<DiagnosisTurn> get copyWith => _$DiagnosisTurnCopyWithImpl<DiagnosisTurn>(this as DiagnosisTurn, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagnosisTurn;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisTurn&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.nextAction, _this.nextAction) || other.nextAction == _this.nextAction)&&(identical(other.questionText, _this.questionText) || other.questionText == _this.questionText)&&(identical(other.diagnosisContent, _this.diagnosisContent) || other.diagnosisContent == _this.diagnosisContent));
}


@override
int get hashCode {
  final _this = this as DiagnosisTurn;
  return Object.hash(runtimeType,_this.confidence,_this.nextAction,_this.questionText,_this.diagnosisContent);
}

@override
String toString() {
  final _this = this as DiagnosisTurn;
  return 'DiagnosisTurn(confidence: ${_this.confidence}, nextAction: ${_this.nextAction}, questionText: ${_this.questionText}, diagnosisContent: ${_this.diagnosisContent})';
}


}

/// @nodoc
abstract mixin class $DiagnosisTurnCopyWith<$Res>  {
  factory $DiagnosisTurnCopyWith(DiagnosisTurn value, $Res Function(DiagnosisTurn) _then) = _$DiagnosisTurnCopyWithImpl;
@useResult
$Res call({
 int confidence, DiagnosisNextAction nextAction, String questionText, DiagnosisContent diagnosisContent
});




}
/// @nodoc
class _$DiagnosisTurnCopyWithImpl<$Res>
    implements $DiagnosisTurnCopyWith<$Res> {
  _$DiagnosisTurnCopyWithImpl(this._self, this._then);

  final DiagnosisTurn _self;
  final $Res Function(DiagnosisTurn) _then;

/// Create a copy of DiagnosisTurn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confidence = null,Object? nextAction = null,Object? questionText = null,Object? diagnosisContent = null,}) {
  return _then(DiagnosisTurn(
confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as int,nextAction: null == nextAction ? _self.nextAction : nextAction // ignore: cast_nullable_to_non_nullable
as DiagnosisNextAction,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,diagnosisContent: null == diagnosisContent ? _self.diagnosisContent : diagnosisContent // ignore: cast_nullable_to_non_nullable
as DiagnosisContent,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisTurn].
extension DiagnosisTurnPatterns on DiagnosisTurn {
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
mixin _$DiagnosisContent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisContent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisContent()';
}


}

/// @nodoc
class $DiagnosisContentCopyWith<$Res>  {
$DiagnosisContentCopyWith(DiagnosisContent _, $Res Function(DiagnosisContent) __);
}


/// Adds pattern-matching-related methods to [DiagnosisContent].
extension DiagnosisContentPatterns on DiagnosisContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FreeTextInputContent value)?  freeTextInput,TResult Function( ChoiceChipsContent value)?  choiceChips,TResult Function( SingleChoiceListContent value)?  singleChoiceList,TResult Function( SummaryConfirmContent value)?  summaryConfirm,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FreeTextInputContent() when freeTextInput != null:
return freeTextInput(_that);case ChoiceChipsContent() when choiceChips != null:
return choiceChips(_that);case SingleChoiceListContent() when singleChoiceList != null:
return singleChoiceList(_that);case SummaryConfirmContent() when summaryConfirm != null:
return summaryConfirm(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FreeTextInputContent value)  freeTextInput,required TResult Function( ChoiceChipsContent value)  choiceChips,required TResult Function( SingleChoiceListContent value)  singleChoiceList,required TResult Function( SummaryConfirmContent value)  summaryConfirm,}){
final _that = this;
switch (_that) {
case FreeTextInputContent():
return freeTextInput(_that);case ChoiceChipsContent():
return choiceChips(_that);case SingleChoiceListContent():
return singleChoiceList(_that);case SummaryConfirmContent():
return summaryConfirm(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FreeTextInputContent value)?  freeTextInput,TResult? Function( ChoiceChipsContent value)?  choiceChips,TResult? Function( SingleChoiceListContent value)?  singleChoiceList,TResult? Function( SummaryConfirmContent value)?  summaryConfirm,}){
final _that = this;
switch (_that) {
case FreeTextInputContent() when freeTextInput != null:
return freeTextInput(_that);case ChoiceChipsContent() when choiceChips != null:
return choiceChips(_that);case SingleChoiceListContent() when singleChoiceList != null:
return singleChoiceList(_that);case SummaryConfirmContent() when summaryConfirm != null:
return summaryConfirm(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  freeTextInput,TResult Function( List<String> options)?  choiceChips,TResult Function( List<String> options)?  singleChoiceList,TResult Function( String summaryText,  String reasoningText)?  summaryConfirm,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FreeTextInputContent() when freeTextInput != null:
return freeTextInput();case ChoiceChipsContent() when choiceChips != null:
return choiceChips(_that.options);case SingleChoiceListContent() when singleChoiceList != null:
return singleChoiceList(_that.options);case SummaryConfirmContent() when summaryConfirm != null:
return summaryConfirm(_that.summaryText,_that.reasoningText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  freeTextInput,required TResult Function( List<String> options)  choiceChips,required TResult Function( List<String> options)  singleChoiceList,required TResult Function( String summaryText,  String reasoningText)  summaryConfirm,}) {final _that = this;
switch (_that) {
case FreeTextInputContent():
return freeTextInput();case ChoiceChipsContent():
return choiceChips(_that.options);case SingleChoiceListContent():
return singleChoiceList(_that.options);case SummaryConfirmContent():
return summaryConfirm(_that.summaryText,_that.reasoningText);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  freeTextInput,TResult? Function( List<String> options)?  choiceChips,TResult? Function( List<String> options)?  singleChoiceList,TResult? Function( String summaryText,  String reasoningText)?  summaryConfirm,}) {final _that = this;
switch (_that) {
case FreeTextInputContent() when freeTextInput != null:
return freeTextInput();case ChoiceChipsContent() when choiceChips != null:
return choiceChips(_that.options);case SingleChoiceListContent() when singleChoiceList != null:
return singleChoiceList(_that.options);case SummaryConfirmContent() when summaryConfirm != null:
return summaryConfirm(_that.summaryText,_that.reasoningText);case _:
  return null;

}
}

}

/// @nodoc


class FreeTextInputContent extends DiagnosisContent {
  const FreeTextInputContent(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeTextInputContent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiagnosisContent.freeTextInput()';
}


}




/// @nodoc


class ChoiceChipsContent extends DiagnosisContent {
  const ChoiceChipsContent({required  List<String> options}): _options = options,super._();
  

 final  List<String> _options;
 List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of DiagnosisContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChoiceChipsContentCopyWith<ChoiceChipsContent> get copyWith => _$ChoiceChipsContentCopyWithImpl<ChoiceChipsContent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChoiceChipsContent&&const DeepCollectionEquality().equals(other.options, _options));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_options));
}

@override
String toString() {
    return 'DiagnosisContent.choiceChips(options: $options)';
}


}

/// @nodoc
abstract mixin class $ChoiceChipsContentCopyWith<$Res> implements $DiagnosisContentCopyWith<$Res> {
  factory $ChoiceChipsContentCopyWith(ChoiceChipsContent value, $Res Function(ChoiceChipsContent) _then) = _$ChoiceChipsContentCopyWithImpl;
@useResult
$Res call({
 List<String> options
});




}
/// @nodoc
class _$ChoiceChipsContentCopyWithImpl<$Res>
    implements $ChoiceChipsContentCopyWith<$Res> {
  _$ChoiceChipsContentCopyWithImpl(this._self, this._then);

  final ChoiceChipsContent _self;
  final $Res Function(ChoiceChipsContent) _then;

/// Create a copy of DiagnosisContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? options = null,}) {
  return _then(ChoiceChipsContent(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class SingleChoiceListContent extends DiagnosisContent {
  const SingleChoiceListContent({required  List<String> options}): _options = options,super._();
  

 final  List<String> _options;
 List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of DiagnosisContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleChoiceListContentCopyWith<SingleChoiceListContent> get copyWith => _$SingleChoiceListContentCopyWithImpl<SingleChoiceListContent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleChoiceListContent&&const DeepCollectionEquality().equals(other.options, _options));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_options));
}

@override
String toString() {
    return 'DiagnosisContent.singleChoiceList(options: $options)';
}


}

/// @nodoc
abstract mixin class $SingleChoiceListContentCopyWith<$Res> implements $DiagnosisContentCopyWith<$Res> {
  factory $SingleChoiceListContentCopyWith(SingleChoiceListContent value, $Res Function(SingleChoiceListContent) _then) = _$SingleChoiceListContentCopyWithImpl;
@useResult
$Res call({
 List<String> options
});




}
/// @nodoc
class _$SingleChoiceListContentCopyWithImpl<$Res>
    implements $SingleChoiceListContentCopyWith<$Res> {
  _$SingleChoiceListContentCopyWithImpl(this._self, this._then);

  final SingleChoiceListContent _self;
  final $Res Function(SingleChoiceListContent) _then;

/// Create a copy of DiagnosisContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? options = null,}) {
  return _then(SingleChoiceListContent(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class SummaryConfirmContent extends DiagnosisContent {
  const SummaryConfirmContent({required this.summaryText, required this.reasoningText}): super._();
  

 final  String summaryText;
 final  String reasoningText;

/// Create a copy of DiagnosisContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryConfirmContentCopyWith<SummaryConfirmContent> get copyWith => _$SummaryConfirmContentCopyWithImpl<SummaryConfirmContent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryConfirmContent&&(identical(other.summaryText, summaryText) || other.summaryText == summaryText)&&(identical(other.reasoningText, reasoningText) || other.reasoningText == reasoningText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summaryText,reasoningText);
}

@override
String toString() {
    return 'DiagnosisContent.summaryConfirm(summaryText: $summaryText, reasoningText: $reasoningText)';
}


}

/// @nodoc
abstract mixin class $SummaryConfirmContentCopyWith<$Res> implements $DiagnosisContentCopyWith<$Res> {
  factory $SummaryConfirmContentCopyWith(SummaryConfirmContent value, $Res Function(SummaryConfirmContent) _then) = _$SummaryConfirmContentCopyWithImpl;
@useResult
$Res call({
 String summaryText, String reasoningText
});




}
/// @nodoc
class _$SummaryConfirmContentCopyWithImpl<$Res>
    implements $SummaryConfirmContentCopyWith<$Res> {
  _$SummaryConfirmContentCopyWithImpl(this._self, this._then);

  final SummaryConfirmContent _self;
  final $Res Function(SummaryConfirmContent) _then;

/// Create a copy of DiagnosisContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summaryText = null,Object? reasoningText = null,}) {
  return _then(SummaryConfirmContent(
summaryText: null == summaryText ? _self.summaryText : summaryText // ignore: cast_nullable_to_non_nullable
as String,reasoningText: null == reasoningText ? _self.reasoningText : reasoningText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DiagnosisAnswer {


/// Create a copy of DiagnosisAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisAnswerCopyWith<DiagnosisAnswer> get copyWith => _$DiagnosisAnswerCopyWithImpl<DiagnosisAnswer>(this as DiagnosisAnswer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagnosisAnswer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisAnswer&&(identical(other.questionText, _this.questionText) || other.questionText == _this.questionText)&&(identical(other.answerText, _this.answerText) || other.answerText == _this.answerText));
}


@override
int get hashCode {
  final _this = this as DiagnosisAnswer;
  return Object.hash(runtimeType,_this.questionText,_this.answerText);
}

@override
String toString() {
  final _this = this as DiagnosisAnswer;
  return 'DiagnosisAnswer(questionText: ${_this.questionText}, answerText: ${_this.answerText})';
}


}

/// @nodoc
abstract mixin class $DiagnosisAnswerCopyWith<$Res>  {
  factory $DiagnosisAnswerCopyWith(DiagnosisAnswer value, $Res Function(DiagnosisAnswer) _then) = _$DiagnosisAnswerCopyWithImpl;
@useResult
$Res call({
 String questionText, String answerText
});




}
/// @nodoc
class _$DiagnosisAnswerCopyWithImpl<$Res>
    implements $DiagnosisAnswerCopyWith<$Res> {
  _$DiagnosisAnswerCopyWithImpl(this._self, this._then);

  final DiagnosisAnswer _self;
  final $Res Function(DiagnosisAnswer) _then;

/// Create a copy of DiagnosisAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? answerText = null,}) {
  return _then(DiagnosisAnswer(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisAnswer].
extension DiagnosisAnswerPatterns on DiagnosisAnswer {
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
