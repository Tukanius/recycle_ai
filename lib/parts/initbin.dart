part of '../models/initbin.dart';

InitBin _$InitBinFromJson(Map<String, dynamic> json) {
  return InitBin(
    PLASTIC: json['PLASTIC'] != null ? json['PLASTIC'] as int : null,
    CAN: json['CAN'] != null ? json['CAN'] as int : null,
    PAPER: json['PAPER'] != null ? json['PAPER'] as int : null,
    OTHER: json['OTHER'] != null ? json['OTHER'] as int : null,
    type: json['type'] != null ? json['type'] as String : null,
    amount: json['amount'] != null ? json['amount'] as int : null,
    totalAmount:
        json['totalAmount'] != null ? json['totalAmount'] as int : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    hasGetNotificationList: json['hasGetNotificationList'] != null
        ? json['hasGetNotificationList'] as bool
        : null,
  );
}

Map<String, dynamic> _$InitBinToJson(InitBin instance) {
  Map<String, dynamic> json = {};

  if (instance.PLASTIC != null) json['PLASTIC'] = instance.PLASTIC;
  if (instance.CAN != null) json['CAN'] = instance.CAN;
  if (instance.PAPER != null) json['PAPER'] = instance.PAPER;
  if (instance.OTHER != null) json['OTHER'] = instance.OTHER;

  if (instance.type != null) json['type'] = instance.type;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.hasGetNotificationList != null)
    json['hasGetNotificationList'] = instance.hasGetNotificationList;

  return json;
}
