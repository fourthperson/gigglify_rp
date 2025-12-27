// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'joke_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JokeResponseModel {

 bool get error; String get category; String get type; String? get joke; String? get setup; String? get delivery; int get id; bool get safe; String get lang;
/// Create a copy of JokeResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JokeResponseModelCopyWith<JokeResponseModel> get copyWith => _$JokeResponseModelCopyWithImpl<JokeResponseModel>(this as JokeResponseModel, _$identity);

  /// Serializes this JokeResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JokeResponseModel&&(identical(other.error, error) || other.error == error)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.joke, joke) || other.joke == joke)&&(identical(other.setup, setup) || other.setup == setup)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.id, id) || other.id == id)&&(identical(other.safe, safe) || other.safe == safe)&&(identical(other.lang, lang) || other.lang == lang));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,category,type,joke,setup,delivery,id,safe,lang);

@override
String toString() {
  return 'JokeResponseModel(error: $error, category: $category, type: $type, joke: $joke, setup: $setup, delivery: $delivery, id: $id, safe: $safe, lang: $lang)';
}


}

/// @nodoc
abstract mixin class $JokeResponseModelCopyWith<$Res>  {
  factory $JokeResponseModelCopyWith(JokeResponseModel value, $Res Function(JokeResponseModel) _then) = _$JokeResponseModelCopyWithImpl;
@useResult
$Res call({
 bool error, String category, String type, String? joke, String? setup, String? delivery, int id, bool safe, String lang
});




}
/// @nodoc
class _$JokeResponseModelCopyWithImpl<$Res>
    implements $JokeResponseModelCopyWith<$Res> {
  _$JokeResponseModelCopyWithImpl(this._self, this._then);

  final JokeResponseModel _self;
  final $Res Function(JokeResponseModel) _then;

/// Create a copy of JokeResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? category = null,Object? type = null,Object? joke = freezed,Object? setup = freezed,Object? delivery = freezed,Object? id = null,Object? safe = null,Object? lang = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,joke: freezed == joke ? _self.joke : joke // ignore: cast_nullable_to_non_nullable
as String?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,delivery: freezed == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as String?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,safe: null == safe ? _self.safe : safe // ignore: cast_nullable_to_non_nullable
as bool,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JokeResponseModel].
extension JokeResponseModelPatterns on JokeResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JokeResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JokeResponseModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JokeResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _JokeResponseModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JokeResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _JokeResponseModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool error,  String category,  String type,  String? joke,  String? setup,  String? delivery,  int id,  bool safe,  String lang)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JokeResponseModel() when $default != null:
return $default(_that.error,_that.category,_that.type,_that.joke,_that.setup,_that.delivery,_that.id,_that.safe,_that.lang);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool error,  String category,  String type,  String? joke,  String? setup,  String? delivery,  int id,  bool safe,  String lang)  $default,) {final _that = this;
switch (_that) {
case _JokeResponseModel():
return $default(_that.error,_that.category,_that.type,_that.joke,_that.setup,_that.delivery,_that.id,_that.safe,_that.lang);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool error,  String category,  String type,  String? joke,  String? setup,  String? delivery,  int id,  bool safe,  String lang)?  $default,) {final _that = this;
switch (_that) {
case _JokeResponseModel() when $default != null:
return $default(_that.error,_that.category,_that.type,_that.joke,_that.setup,_that.delivery,_that.id,_that.safe,_that.lang);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JokeResponseModel extends JokeResponseModel {
   _JokeResponseModel({required this.error, required this.category, required this.type, required this.joke, required this.setup, required this.delivery, required this.id, required this.safe, required this.lang}): super._();
  factory _JokeResponseModel.fromJson(Map<String, dynamic> json) => _$JokeResponseModelFromJson(json);

@override final  bool error;
@override final  String category;
@override final  String type;
@override final  String? joke;
@override final  String? setup;
@override final  String? delivery;
@override final  int id;
@override final  bool safe;
@override final  String lang;

/// Create a copy of JokeResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JokeResponseModelCopyWith<_JokeResponseModel> get copyWith => __$JokeResponseModelCopyWithImpl<_JokeResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JokeResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JokeResponseModel&&(identical(other.error, error) || other.error == error)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.joke, joke) || other.joke == joke)&&(identical(other.setup, setup) || other.setup == setup)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.id, id) || other.id == id)&&(identical(other.safe, safe) || other.safe == safe)&&(identical(other.lang, lang) || other.lang == lang));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,category,type,joke,setup,delivery,id,safe,lang);

@override
String toString() {
  return 'JokeResponseModel(error: $error, category: $category, type: $type, joke: $joke, setup: $setup, delivery: $delivery, id: $id, safe: $safe, lang: $lang)';
}


}

/// @nodoc
abstract mixin class _$JokeResponseModelCopyWith<$Res> implements $JokeResponseModelCopyWith<$Res> {
  factory _$JokeResponseModelCopyWith(_JokeResponseModel value, $Res Function(_JokeResponseModel) _then) = __$JokeResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool error, String category, String type, String? joke, String? setup, String? delivery, int id, bool safe, String lang
});




}
/// @nodoc
class __$JokeResponseModelCopyWithImpl<$Res>
    implements _$JokeResponseModelCopyWith<$Res> {
  __$JokeResponseModelCopyWithImpl(this._self, this._then);

  final _JokeResponseModel _self;
  final $Res Function(_JokeResponseModel) _then;

/// Create a copy of JokeResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? category = null,Object? type = null,Object? joke = freezed,Object? setup = freezed,Object? delivery = freezed,Object? id = null,Object? safe = null,Object? lang = null,}) {
  return _then(_JokeResponseModel(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,joke: freezed == joke ? _self.joke : joke // ignore: cast_nullable_to_non_nullable
as String?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,delivery: freezed == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as String?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,safe: null == safe ? _self.safe : safe // ignore: cast_nullable_to_non_nullable
as bool,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
