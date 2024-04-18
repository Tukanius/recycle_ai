import 'package:smart_bin_flutter/models/initbin.dart';
import 'package:smart_bin_flutter/models/result.dart';
import 'package:smart_bin_flutter/models/trash_notification.dart';
import 'package:smart_bin_flutter/models/userqr.dart';
import 'package:smart_bin_flutter/utils/http_request.dart';

class EcoBinApi extends HttpRequest {
  getInit() async {
    var res = await get("/user/eco-bin/init", handler: true);
    return InitBin.fromJson(res as Map<String, dynamic>);
  }

  getQr(String id) async {
    var res = await get("/user/$id/qrcode", handler: true);
    return UserQr.fromJson(res as Map<String, dynamic>);
  }

  getHistory(ResultArguments resultArguments) async {
    var res =
        await get('/user/eco-bin/histories', data: resultArguments.toJson());
    return Result.fromJson(res, InitBin.fromJson);
  }

  getNotify(ResultArguments resultArguments) async {
    var res = await get('/user/eco-bin/notifications',
        data: resultArguments.toJson());
    return Result.fromJson(res, TrashNotification.fromJson);
  }

  getNotifyItem(String id) async {
    var res = await get(
      '/user/eco-bin/notifications/${id}',
    );
    return TrashNotification.fromJson(res as Map<String, dynamic>);
  }
}
