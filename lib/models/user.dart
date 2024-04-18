part '../parts/user.dart';

class User {
  String? id;
  bool? isActive;
  String? email;
  String? phone;
  int? expiryHours;
  String? userStatus;
  String? userStatusDate;
  String? createdAt;
  String? updatedAt;
  String? sessionId;

  String? message;

  String? username;
  String? password;
  String? sessionScope;

  bool? passwordExpired;
  bool? passwordNeedChange;
  String? tokenType;
  String? accessToken;
  String? refreshToken;
  String? sessionState;
  String? otpMethod;
  String? otpCode;

  User({
    this.otpMethod,
    this.otpCode,
    this.tokenType,
    this.accessToken,
    this.refreshToken,
    this.sessionState,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.sessionId,
    this.isActive,
    this.email,
    this.username,
    this.phone,
    this.password,
    this.sessionScope,
    this.expiryHours,
    this.passwordExpired,
    this.passwordNeedChange,
    this.userStatus,
    this.userStatusDate,
    this.message,
  });

  static $fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
