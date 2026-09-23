// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Quiz {


/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizCopyWith<Quiz> get copyWith => _$QuizCopyWithImpl<Quiz>(this as Quiz, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Quiz;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quiz&&(identical(other.qid, _this.qid) || other.qid == _this.qid)&&(identical(other.questionText, _this.questionText) || other.questionText == _this.questionText)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.referenceAnswer, _this.referenceAnswer) || other.referenceAnswer == _this.referenceAnswer)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.codeSnippet, _this.codeSnippet) || other.codeSnippet == _this.codeSnippet)&&(identical(other.quizContent, _this.quizContent) || other.quizContent == _this.quizContent));
}


@override
int get hashCode {
  final _this = this as Quiz;
  return Object.hash(runtimeType,_this.qid,_this.questionText,_this.category,_this.difficulty,_this.referenceAnswer,_this.imageUrl,_this.codeSnippet,_this.quizContent);
}

@override
String toString() {
  final _this = this as Quiz;
  return 'Quiz(qid: ${_this.qid}, questionText: ${_this.questionText}, category: ${_this.category}, difficulty: ${_this.difficulty}, referenceAnswer: ${_this.referenceAnswer}, imageUrl: ${_this.imageUrl}, codeSnippet: ${_this.codeSnippet}, quizContent: ${_this.quizContent})';
}


}

/// @nodoc
abstract mixin class $QuizCopyWith<$Res>  {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) _then) = _$QuizCopyWithImpl;
@useResult
$Res call({
 String questionText, Category category, String difficulty, String referenceAnswer, QuizContent quizContent, String? imageUrl, CodeSnippet? codeSnippet, String qid
});




}
/// @nodoc
class _$QuizCopyWithImpl<$Res>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._self, this._then);

  final Quiz _self;
  final $Res Function(Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? category = null,Object? difficulty = null,Object? referenceAnswer = null,Object? quizContent = null,Object? imageUrl = freezed,Object? codeSnippet = freezed,Object? qid = null,}) {
  return _then(Quiz(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,referenceAnswer: null == referenceAnswer ? _self.referenceAnswer : referenceAnswer // ignore: cast_nullable_to_non_nullable
as String,quizContent: null == quizContent ? _self.quizContent : quizContent // ignore: cast_nullable_to_non_nullable
as QuizContent,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,codeSnippet: freezed == codeSnippet ? _self.codeSnippet : codeSnippet // ignore: cast_nullable_to_non_nullable
as CodeSnippet?,qid: null == qid ? _self.qid : qid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Quiz].
extension QuizPatterns on Quiz {
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
mixin _$Category {


/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCopyWith<Category> get copyWith => _$CategoryCopyWithImpl<Category>(this as Category, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Category;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Category&&(identical(other.main, _this.main) || other.main == _this.main)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.subTopic, _this.subTopic) || other.subTopic == _this.subTopic));
}


@override
int get hashCode {
  final _this = this as Category;
  return Object.hash(runtimeType,_this.main,_this.topic,_this.subTopic);
}

@override
String toString() {
  final _this = this as Category;
  return 'Category(main: ${_this.main}, topic: ${_this.topic}, subTopic: ${_this.subTopic})';
}


}

/// @nodoc
abstract mixin class $CategoryCopyWith<$Res>  {
  factory $CategoryCopyWith(Category value, $Res Function(Category) _then) = _$CategoryCopyWithImpl;
@useResult
$Res call({
 String main, String topic, String subTopic
});




}
/// @nodoc
class _$CategoryCopyWithImpl<$Res>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._self, this._then);

  final Category _self;
  final $Res Function(Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? main = null,Object? topic = null,Object? subTopic = null,}) {
  return _then(Category(
main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,subTopic: null == subTopic ? _self.subTopic : subTopic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Category].
extension CategoryPatterns on Category {
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
mixin _$CodeSnippet {


/// Create a copy of CodeSnippet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeSnippetCopyWith<CodeSnippet> get copyWith => _$CodeSnippetCopyWithImpl<CodeSnippet>(this as CodeSnippet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CodeSnippet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeSnippet&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.code, _this.code) || other.code == _this.code));
}


@override
int get hashCode {
  final _this = this as CodeSnippet;
  return Object.hash(runtimeType,_this.language,_this.code);
}

@override
String toString() {
  final _this = this as CodeSnippet;
  return 'CodeSnippet(language: ${_this.language}, code: ${_this.code})';
}


}

/// @nodoc
abstract mixin class $CodeSnippetCopyWith<$Res>  {
  factory $CodeSnippetCopyWith(CodeSnippet value, $Res Function(CodeSnippet) _then) = _$CodeSnippetCopyWithImpl;
@useResult
$Res call({
 String language, String code
});




}
/// @nodoc
class _$CodeSnippetCopyWithImpl<$Res>
    implements $CodeSnippetCopyWith<$Res> {
  _$CodeSnippetCopyWithImpl(this._self, this._then);

  final CodeSnippet _self;
  final $Res Function(CodeSnippet) _then;

/// Create a copy of CodeSnippet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? code = null,}) {
  return _then(CodeSnippet(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeSnippet].
extension CodeSnippetPatterns on CodeSnippet {
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
mixin _$QuizContent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizContent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizContent()';
}


}

/// @nodoc
class $QuizContentCopyWith<$Res>  {
$QuizContentCopyWith(QuizContent _, $Res Function(QuizContent) __);
}


/// Adds pattern-matching-related methods to [QuizContent].
extension QuizContentPatterns on QuizContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShortAnswerContent value)?  shortAnswer,TResult Function( SingleChoiceContent value)?  singleChoice,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShortAnswerContent() when shortAnswer != null:
return shortAnswer(_that);case SingleChoiceContent() when singleChoice != null:
return singleChoice(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShortAnswerContent value)  shortAnswer,required TResult Function( SingleChoiceContent value)  singleChoice,}){
final _that = this;
switch (_that) {
case ShortAnswerContent():
return shortAnswer(_that);case SingleChoiceContent():
return singleChoice(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShortAnswerContent value)?  shortAnswer,TResult? Function( SingleChoiceContent value)?  singleChoice,}){
final _that = this;
switch (_that) {
case ShortAnswerContent() when shortAnswer != null:
return shortAnswer(_that);case SingleChoiceContent() when singleChoice != null:
return singleChoice(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  shortAnswer,TResult Function( List<String> options,  int correctIndex)?  singleChoice,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShortAnswerContent() when shortAnswer != null:
return shortAnswer();case SingleChoiceContent() when singleChoice != null:
return singleChoice(_that.options,_that.correctIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  shortAnswer,required TResult Function( List<String> options,  int correctIndex)  singleChoice,}) {final _that = this;
switch (_that) {
case ShortAnswerContent():
return shortAnswer();case SingleChoiceContent():
return singleChoice(_that.options,_that.correctIndex);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  shortAnswer,TResult? Function( List<String> options,  int correctIndex)?  singleChoice,}) {final _that = this;
switch (_that) {
case ShortAnswerContent() when shortAnswer != null:
return shortAnswer();case SingleChoiceContent() when singleChoice != null:
return singleChoice(_that.options,_that.correctIndex);case _:
  return null;

}
}

}

/// @nodoc


class ShortAnswerContent extends QuizContent {
  const ShortAnswerContent(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortAnswerContent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QuizContent.shortAnswer()';
}


}




/// @nodoc


class SingleChoiceContent extends QuizContent {
  const SingleChoiceContent({required  List<String> options, required this.correctIndex}): _options = options,super._();
  

 final  List<String> _options;
 List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  int correctIndex;

/// Create a copy of QuizContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleChoiceContentCopyWith<SingleChoiceContent> get copyWith => _$SingleChoiceContentCopyWithImpl<SingleChoiceContent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleChoiceContent&&const DeepCollectionEquality().equals(other.options, _options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_options),correctIndex);
}

@override
String toString() {
    return 'QuizContent.singleChoice(options: $options, correctIndex: $correctIndex)';
}


}

/// @nodoc
abstract mixin class $SingleChoiceContentCopyWith<$Res> implements $QuizContentCopyWith<$Res> {
  factory $SingleChoiceContentCopyWith(SingleChoiceContent value, $Res Function(SingleChoiceContent) _then) = _$SingleChoiceContentCopyWithImpl;
@useResult
$Res call({
 List<String> options, int correctIndex
});




}
/// @nodoc
class _$SingleChoiceContentCopyWithImpl<$Res>
    implements $SingleChoiceContentCopyWith<$Res> {
  _$SingleChoiceContentCopyWithImpl(this._self, this._then);

  final SingleChoiceContent _self;
  final $Res Function(SingleChoiceContent) _then;

/// Create a copy of QuizContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? options = null,Object? correctIndex = null,}) {
  return _then(SingleChoiceContent(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
