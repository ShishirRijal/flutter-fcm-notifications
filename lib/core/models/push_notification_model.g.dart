// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PushNotificationModel _$PushNotificationModelFromJson(
  Map<String, dynamic> json,
) => _PushNotificationModel(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  data: json['data'] as Map<String, dynamic>,
  receivedAt: DateTime.parse(json['receivedAt'] as String),
);

Map<String, dynamic> _$PushNotificationModelToJson(
  _PushNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'data': instance.data,
  'receivedAt': instance.receivedAt.toIso8601String(),
};

const _$NotificationTypeEnumMap = {
  NotificationType.friendRequest: 'friendRequest',
  NotificationType.chat: 'chat',
  NotificationType.like: 'like',
  NotificationType.unknown: 'unknown',
};
