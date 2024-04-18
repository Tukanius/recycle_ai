part of '../models/trash_notification.dart';

TrashNotification _$TrashNotificationFromJson(Map<String, dynamic> json) {
  return TrashNotification(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    title: json['title'] != null ? json['title'] as String : null,
    body: json['body'] != null ? json['body'] as String : null,
    hasGetItem: json['hasGetItem'] != null ? json['hasGetItem'] as bool : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
  );
}

Map<String, dynamic> _$TrashNotificationToJson(TrashNotification instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.title != null) json['title'] = instance.title;
  if (instance.body != null) json['body'] = instance.body;
  if (instance.hasGetItem != null) json['hasGetItem'] = instance.hasGetItem;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;

  return json;
}
