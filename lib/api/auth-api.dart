import 'package:smart_bin_flutter/utils/http_request.dart';

import '../models/user.dart';

class AuthApi extends HttpRequest {
  login(User user) async {
    var res = await post('/auth/login', data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  setPassword(User user) async {
    var res =
        await post('/auth/password/change', data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  me(bool handler) async {
    var res = await get('/user/me', handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  register(User user) async {
    var res = await post("/auth/register", data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  getOtp() async {
    var res = await get('/auth/otp?otpMethod=FORGOT', handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  otpVerify(User data) async {
    Map<String, dynamic> json = {};
    json['otpCode'] = data.otpCode;
    json['otpMethod'] = data.otpMethod;
    var res = await post('/auth/otp/verify', data: json, handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  logout() async {
    var res = await get('/auth/logout', handler: false);
    return User.fromJson(res as Map<String, dynamic>);
  }
}
