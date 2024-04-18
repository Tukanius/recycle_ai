import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin_flutter/components/controller/listen.dart';
import 'package:smart_bin_flutter/models/user.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/src/auth/login_page.dart';
import 'package:smart_bin_flutter/src/auth/password_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';
import 'package:pinput/pinput.dart';

class OtpPageArguments {
  String? username;
  OtpPageArguments({
    this.username,
  });
}

class OtpPage extends StatefulWidget {
  final String? username;
  static const routeName = "OtpPage";
  const OtpPage({
    super.key,
    this.username,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with AfterLayoutMixin {
  int _counter = 180;
  TextEditingController controller = TextEditingController();
  bool isGetCode = false;
  bool isSubmit = false;
  bool isLoading = true;
  late Timer _timer;
  String username = "";
  User user = User();
  ListenController listenController = ListenController();

  @override
  void initState() {
    listenController.addListener(() async {
      await Provider.of<UserProvider>(context, listen: false).getOtp();
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    _startTimer();
    setState(() {
      username = widget.username!;
    });
    user = await Provider.of<UserProvider>(context, listen: false).getOtp();
    setState(() {
      isLoading = false;
    });
  }

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String minutes = m.toString().padLeft(2, '0');
    String seconds = s.toString().padLeft(2, '0');
    String result = "$minutes:$seconds";
    return result;
  }

  checkOpt(value) async {
    user.otpCode = value;
    await await Provider.of<UserProvider>(context, listen: false)
        .otpVerify(user);
    await Navigator.of(context).pushNamed(PassWordPage.routeName,
        arguments: PassWordPageArguments(isForgot: false));
  }

  void _startTimer() async {
    if (isSubmit == true) {
      setState(() {
        isGetCode = false;
      });
      _counter = 180;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    } else {
      setState(() {
        isGetCode = false;
      });
      _counter = 180;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    }
  }

  final defaultPinTheme = PinTheme(
    width: 80,
    height: 80,
    textStyle:
        TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: greytext,
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/dahivar/recycle.svg'),
            SizedBox(
              height: 10,
            ),
            Text(
              'Баталгаажуулалт',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greentext,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: greentext,
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        // '${widget.username} дугаар-луу явуулсан 6 оронтой тоог оруулна уу.',
                        '${user.message}',
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (isGetCode == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Дахин код авах ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              '${intToTimeLeft(_counter)} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              'секунд',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isSubmit = true;
                                });
                                _startTimer();
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getOtp();
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: black,
                                  ),
                                  Text(
                                    "Код дахин авах",
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).iconTheme.color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Баталгаажуулалт',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onCompleted: (value) => checkOpt(value),
                        validator: (value) {
                          return value == "${user.otpCode}"
                              ? null
                              : "Буруу байна";
                        },
                        length: 6,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        defaultPinTheme: defaultPinTheme,
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // CustomButton(
                      //   onClick: () {},
                      //   buttonColor: buttongreen,
                      //   labelText: 'Баталгаажуулалт',
                      //   textColor: white,
                      //   isLoading: false,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
