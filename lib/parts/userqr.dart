part of '../models/userqr.dart';

UserQr _$UserQrFromJson(Map<String, dynamic> json) {
  return UserQr(
    image: json['image'] != null ? json['image'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    token: json['token'] != null ? json['token'] as String : null,
    success: json['success'] != null ? json['success'] as bool : null,
  );
}

Map<String, dynamic> _$UserQrToJson(UserQr instance) {
  Map<String, dynamic> json = {};
  if (instance.image != null) json['image'] = instance.image;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.token != null) json['token'] = instance.token;
  if (instance.success != null) json['success'] = instance.success;

  return json;
}
