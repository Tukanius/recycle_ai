part '../parts/trash_notification.dart';

class TrashNotification {
  String? id;
  String? type;
  String? title;
  String? body;
  bool? hasGetItem;
  String? createdAt;

  TrashNotification({
    this.id,
    this.type,
    this.title,
    this.body,
    this.hasGetItem,
    this.createdAt,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$TrashNotificationFromJson(json);

  factory TrashNotification.fromJson(Map<String, dynamic> json) =>
      _$TrashNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$TrashNotificationToJson(this);
}
