import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smart_bin_flutter/api/qr-api.dart';
import 'package:smart_bin_flutter/models/userqr.dart';
import 'package:smart_bin_flutter/src/main_page.dart';

class QrSuccessPageArguments {
  Barcode data;

  QrSuccessPageArguments({
    required this.data,
  });
}

class QrSuccessPage extends StatefulWidget {
  final Barcode data;
  static const routeName = "QrSuccessPage";
  const QrSuccessPage({super.key, required this.data});

  @override
  State<QrSuccessPage> createState() => _QrSuccessPageState();
}

class _QrSuccessPageState extends State<QrSuccessPage> with AfterLayoutMixin {
  UserQr qr = UserQr(success: false);
  bool isSuccess = false;
  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      qr.token = widget.data.code;
    });
    qr = await QrApi().sendQr(qr.token!);
    setState(() {
      isSuccess = qr.success!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: qr.success == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/qrSuccess.json',
                          height: 200, repeat: false, fit: BoxFit.cover),
                      Text(
                        'Амжилттай',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Таны дансанд амжилттай орлоо.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(MainPage.routeName);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/qrError.json',
                          height: 200, repeat: false, fit: BoxFit.cover),
                      Text(
                        'Амжилтгүй ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Таны уншуулсан QR буруу байна дахин оролдоно уу.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(MainPage.routeName);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
