part '../parts/userqr.dart';

class UserQr {
  String? image;
  String? url;
  String? token;
  bool? success;
  UserQr({
    this.image,
    this.url,
    this.token,
    this.success,
  });
  static $fromJson(Map<String, dynamic> json) => _$UserQrFromJson(json);

  factory UserQr.fromJson(Map<String, dynamic> json) => _$UserQrFromJson(json);
  Map<String, dynamic> toJson() => _$UserQrToJson(this);
}
