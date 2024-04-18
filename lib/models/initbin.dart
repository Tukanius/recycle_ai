part '../parts/initbin.dart';

class InitBin {
  int? PLASTIC;
  int? CAN;
  int? PAPER;
  int? OTHER;
  bool? hasGetNotificationList;

  String? type;
  int? amount;
  int? totalAmount;
  String? createdAt;

  InitBin({
    this.PLASTIC,
    this.CAN,
    this.PAPER,
    this.OTHER,
    this.type,
    this.amount,
    this.totalAmount,
    this.createdAt,
    this.hasGetNotificationList,
  });
  static $fromJson(Map<String, dynamic> json) => _$InitBinFromJson(json);

  factory InitBin.fromJson(Map<String, dynamic> json) =>
      _$InitBinFromJson(json);
  Map<String, dynamic> toJson() => _$InitBinToJson(this);
}
