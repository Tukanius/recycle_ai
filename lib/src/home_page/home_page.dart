import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_bin_flutter/api/ecobin-api.dart';
import 'package:smart_bin_flutter/components/controller/listen.dart';
import 'package:smart_bin_flutter/components/custom_button/custom_button.dart';
import 'package:smart_bin_flutter/components/history_card/history_card.dart';
import 'package:smart_bin_flutter/components/info_card/info_card.dart';
import 'package:smart_bin_flutter/components/refresher/refresher.dart';
import 'package:smart_bin_flutter/models/initbin.dart';
import 'package:smart_bin_flutter/models/result.dart';
import 'package:smart_bin_flutter/models/user.dart';
import 'package:smart_bin_flutter/models/userqr.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/src/notification_page/notification_page.dart';
import 'package:smart_bin_flutter/src/splash_screen/splash_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  User user = User();
  InitBin init = InitBin();
  UserQr qr = UserQr();
  bool isLoading = true;
  bool isLoadingPage = true;
  int page = 1;
  int limit = 10;
  Result history = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) async {
    qr = await EcoBinApi().getQr(user.id!);
    init = await Provider.of<UserProvider>(context, listen: false).getBinInit();
    await list(page, limit);
    setState(() {
      isLoading = false;
      isLoadingPage = false;
    });
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter();
    history = await EcoBinApi()
        .getHistory(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  logoutAcc() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).logout();
      await Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  void logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: white,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Та гарахдаа итгэлтэй байна уу?',
                  style: TextStyle(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        buttonColor: greytext,
                        isLoading: isLoading,
                        labelText: 'Болих',
                        textColor: black,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        buttonColor: buttongreen,
                        isLoading: isLoading,
                        labelText: 'Гарах',
                        textColor: white,
                        onClick: () {
                          logoutAcc();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showSvgDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 250,
            height: 250,
            child: QrImageView(
              data: "${qr.url}",
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: black,
              ),
              eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: black,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/dahivar/recycle.svg',
          height: 32,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(NotificationPage.routeName);
            },
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset('assets/svg/notification.svg'),
                ),
                init.hasGetNotificationList == true
                    ? SizedBox()
                    : Positioned(
                        top: 0,
                        left: 25,
                        right: 0,
                        child: SvgPicture.asset(
                          'assets/svg/active_dot.svg',
                          height: 25,
                          width: 25,
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              logout(context);
            },
            child: SvgPicture.asset('assets/svg/logout.svg'),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: isLoadingPage == true
          ? Center(
              child: CircularProgressIndicator(
                color: greentext,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              onLoading: onLoading,
              onRefresh: onRefresh,
              color: greentext,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 11),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.phone == null ? '0' : '${user.phone}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Last login: 2024.04.14',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showSvgDialog(context);
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                child: QrImageView(
                                  data: "${qr.url}",
                                  dataModuleStyle: QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: black,
                                  ),
                                  eyeStyle: QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InfoCard(
                            svg: "assets/svg/plastic.svg",
                            number: init.PLASTIC,
                            type: 'Хуванцар',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InfoCard(
                            svg: "assets/svg/can.svg",
                            number: init.CAN,
                            type: 'Лааз',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InfoCard(
                            svg: "assets/svg/paper.svg",
                            number: init.PAPER,
                            type: 'Цаас',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InfoCard(
                            svg: "assets/svg/other.svg",
                            number: init.OTHER,
                            type: 'Бусад хаягдал',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, bottom: 10),
                        child: Text(
                          'Түүх',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      history.rows!.length != 0
                          ? Column(
                              children: history.rows!
                                  .map((data) => Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: HistoryCard(
                                          data: data,
                                        ),
                                      ))
                                  .toList())
                          : Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Түүх алга байна.',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
