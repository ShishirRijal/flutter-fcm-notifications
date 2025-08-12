import 'package:firebase_messaging/firebase_messaging.dart';

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

/// Model representing a push notification with parsed data and behavior
class PushNotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final bool isActionable;

  const PushNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.receivedAt,
    required this.isActionable,
  });

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
      isActionable: _isTypeActionable(notificationType),
    );
  }

  /// Factory constructor to create from JSON (for storage/restoration)
  factory PushNotificationModel.fromJson(Map<String, dynamic> json) {
    return PushNotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: NotificationType.fromString(json['type'] as String),
      data: Map<String, dynamic>.from(json['data'] as Map),
      receivedAt: DateTime.parse(json['receivedAt'] as String),
      isActionable: json['isActionable'] as bool,
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type.value,
      'data': data,
      'receivedAt': receivedAt.toIso8601String(),
      'isActionable': isActionable,
    };
  }

  /// Determine if a notification type requires user action
  static bool _isTypeActionable(NotificationType type) {
    switch (type) {
      case NotificationType.friendRequest:
      case NotificationType.chat:
        return true;
      case NotificationType.like:
      case NotificationType.unknown:
        return false;
    }
  }

  /// Get the route path for navigation based on notification type
  String get routePath {
    switch (type) {
      case NotificationType.friendRequest:
        return '/friendRequests';
      case NotificationType.chat:
        return '/chat';
      case NotificationType.like:
        return '/profile';
      case NotificationType.unknown:
        return '/';
    }
  }

  /// Get priority level for display purposes
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

  /// Get icon for notification display
  String get iconPath {
    switch (type) {
      case NotificationType.friendRequest:
        return 'assets/icons/friend_request.png';
      case NotificationType.chat:
        return 'assets/icons/chat.png';
      case NotificationType.like:
        return 'assets/icons/like.png';
      case NotificationType.unknown:
        return 'assets/icons/notification.png';
    }
  }

  /// Check if notification should wake up the screen
  bool get shouldWakeScreen {
    return type == NotificationType.friendRequest ||
        type == NotificationType.chat;
  }

  /// Check if notification should show as heads-up
  bool get shouldShowHeadsUp {
    return priority == NotificationPriority.high;
  }

  /// Get context-specific data based on notification type
  T? getContextData<T>(String key) {
    return data[key] as T?;
  }

  /// Convenience getters for common data fields
  String? get userId => getContextData<String>('userId');
  String? get chatId => getContextData<String>('chatId');
  String? get fromUserId => getContextData<String>('fromUserId');
  String? get requestId => getContextData<String>('requestId');

  /// Create a copy with updated values
  PushNotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    Map<String, dynamic>? data,
    DateTime? receivedAt,
    bool? isActionable,
  }) {
    return PushNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      data: data ?? this.data,
      receivedAt: receivedAt ?? this.receivedAt,
      isActionable: isActionable ?? this.isActionable,
    );
  }

  @override
  String toString() {
    return 'PushNotificationModel(id: $id, type: ${type.value}, title: $title, isActionable: $isActionable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PushNotificationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Enum for notification priority levels
enum NotificationPriority { low, medium, high, critical }
