// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_bin_flutter/api/auth-api.dart';
import 'package:smart_bin_flutter/api/ecobin-api.dart';
import 'package:smart_bin_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user = User();

  login(User data) async {
    user = await AuthApi().login(data);
    setAccessToken(user.accessToken);
    notifyListeners();
  }

  register(User data) async {
    user = await AuthApi().register(data);
    setAccessToken(user.accessToken);
    return user;
  }

  me(bool handler) async {
    user = await AuthApi().me(handler);
    notifyListeners();
  }

  setPassword(User data) async {
    user = await AuthApi().setPassword(data);
    setAccessToken(user.accessToken);
    return user;
  }

  setAccessToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("ACCESS_TOKEN", token);
  }

  getOtp() async {
    User res = await AuthApi().getOtp();
    await setAccessToken(res.accessToken);
    return res;
  }

  getBinInit() async {
    var res = await EcoBinApi().getInit();
    await setAccessToken(user.accessToken);
    notifyListeners();
    return res;
  }

  getQr() async {
    var res = await EcoBinApi().getQr(user.id!);
    await setAccessToken(user.accessToken);
    notifyListeners();
    return res;
  }

  otpVerify(User data) async {
    data = await AuthApi().otpVerify(data);
    await setAccessToken(data.accessToken);
    return data;
  }

  logout() async {
    user = User();
    clearAccessToken();
  }

  clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("ACCESS_TOKEN");
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("ACCESS_TOKEN");
    return token;
  }
}
