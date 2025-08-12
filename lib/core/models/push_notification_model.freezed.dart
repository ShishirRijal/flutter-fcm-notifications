// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushNotificationModel {

 String get id; String get title; String get body; NotificationType get type; Map<String, dynamic> get data; DateTime get receivedAt;
/// Create a copy of PushNotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushNotificationModelCopyWith<PushNotificationModel> get copyWith => _$PushNotificationModelCopyWithImpl<PushNotificationModel>(this as PushNotificationModel, _$identity);

  /// Serializes this PushNotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,const DeepCollectionEquality().hash(data),receivedAt);

@override
String toString() {
  return 'PushNotificationModel(id: $id, title: $title, body: $body, type: $type, data: $data, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class $PushNotificationModelCopyWith<$Res>  {
  factory $PushNotificationModelCopyWith(PushNotificationModel value, $Res Function(PushNotificationModel) _then) = _$PushNotificationModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, NotificationType type, Map<String, dynamic> data, DateTime receivedAt
});




}
/// @nodoc
class _$PushNotificationModelCopyWithImpl<$Res>
    implements $PushNotificationModelCopyWith<$Res> {
  _$PushNotificationModelCopyWithImpl(this._self, this._then);

  final PushNotificationModel _self;
  final $Res Function(PushNotificationModel) _then;

/// Create a copy of PushNotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? data = null,Object? receivedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PushNotificationModel].
extension PushNotificationModelPatterns on PushNotificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushNotificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushNotificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushNotificationModel value)  $default,){
final _that = this;
switch (_that) {
case _PushNotificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushNotificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _PushNotificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  NotificationType type,  Map<String, dynamic> data,  DateTime receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushNotificationModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.data,_that.receivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  NotificationType type,  Map<String, dynamic> data,  DateTime receivedAt)  $default,) {final _that = this;
switch (_that) {
case _PushNotificationModel():
return $default(_that.id,_that.title,_that.body,_that.type,_that.data,_that.receivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  NotificationType type,  Map<String, dynamic> data,  DateTime receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _PushNotificationModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.data,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushNotificationModel implements PushNotificationModel {
  const _PushNotificationModel({required this.id, required this.title, required this.body, required this.type, required final  Map<String, dynamic> data, required this.receivedAt}): _data = data;
  factory _PushNotificationModel.fromJson(Map<String, dynamic> json) => _$PushNotificationModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String body;
@override final  NotificationType type;
 final  Map<String, dynamic> _data;
@override Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override final  DateTime receivedAt;

/// Create a copy of PushNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushNotificationModelCopyWith<_PushNotificationModel> get copyWith => __$PushNotificationModelCopyWithImpl<_PushNotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushNotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,const DeepCollectionEquality().hash(_data),receivedAt);

@override
String toString() {
  return 'PushNotificationModel(id: $id, title: $title, body: $body, type: $type, data: $data, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$PushNotificationModelCopyWith<$Res> implements $PushNotificationModelCopyWith<$Res> {
  factory _$PushNotificationModelCopyWith(_PushNotificationModel value, $Res Function(_PushNotificationModel) _then) = __$PushNotificationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, NotificationType type, Map<String, dynamic> data, DateTime receivedAt
});




}
/// @nodoc
class __$PushNotificationModelCopyWithImpl<$Res>
    implements _$PushNotificationModelCopyWith<$Res> {
  __$PushNotificationModelCopyWithImpl(this._self, this._then);

  final _PushNotificationModel _self;
  final $Res Function(_PushNotificationModel) _then;

/// Create a copy of PushNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? data = null,Object? receivedAt = null,}) {
  return _then(_PushNotificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
