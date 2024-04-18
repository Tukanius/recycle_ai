import 'package:smart_bin_flutter/models/userqr.dart';
import 'package:smart_bin_flutter/utils/http_request.dart';

class QrApi extends HttpRequest {
  sendQr(String data) async {
    var res =
        await post('/user/eco-bin/qrcode/scan', data: data, handler: false);
    return UserQr.fromJson(res as Map<String, dynamic>);
  }
}
