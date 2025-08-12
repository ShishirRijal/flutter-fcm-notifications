import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification_model.g.dart';
part 'push_notification_model.freezed.dart';

@freezed
abstract class PushNotificationModel with _$PushNotificationModel {
  const factory PushNotificationModel({
    required String id,
    required String title,
    required String body,
    required NotificationType type,
    required Map<String, dynamic> data,
    required DateTime receivedAt,
  }) = _PushNotificationModel;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationModelFromJson(json);

  /// Factory constructor to create from Firebase RemoteMessage
  factory PushNotificationModel.fromRemoteMessage(RemoteMessage message) {
    final notificationType = NotificationType.fromString(
      message.data['type']?.toString() ?? 'unknown',
    );

    return PushNotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? 'New Notification',
      body: message.notification?.body ?? 'You have a new message',
      type: notificationType,
      data: message.data,
      receivedAt: DateTime.now(),
    );
  }
}

/// Enum defining different types of notifications
enum NotificationType {
  friendRequest('friend_request'),
  chat('chat'),
  like('like'),
  unknown('unknown');

  const NotificationType(this.value);
  final String value;

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => NotificationType.unknown,
    );
  }
}

/// Enum for notification priority levels
enum NotificationPriority { low, medium, high, critical }

// extension

extension PushNotificationX on PushNotificationModel {
  String get routePath {
    switch (type) {
      case NotificationType.friendRequest:
        return '/friend_request';
      case NotificationType.chat:
        return '/chat';
      case NotificationType.like:
        return '/profile';
      case NotificationType.unknown:
        return '/';
    }
  }

  NotificationPriority get priority {
    switch (type) {
      case NotificationType.friendRequest:
      case NotificationType.chat:
        return NotificationPriority.high;
      case NotificationType.like:
        return NotificationPriority.medium;
      case NotificationType.unknown:
        return NotificationPriority.low;
    }
  }

  bool get shouldWakeScreen {
    return type == NotificationType.friendRequest ||
        type == NotificationType.chat;
  }

  bool get shouldShowHeadsUp {
    return priority == NotificationPriority.high;
  }
}
