import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_bin_flutter/api/ecobin-api.dart';
import 'package:smart_bin_flutter/components/notification_card/notification_card.dart';
import 'package:smart_bin_flutter/components/refresher/refresher.dart';
import 'package:smart_bin_flutter/models/result.dart';
import 'package:smart_bin_flutter/models/trash_notification.dart';
import 'package:smart_bin_flutter/src/notification_page/notification_detail_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = "NotificationPage";
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AfterLayoutMixin {
  TrashNotification trash = TrashNotification();
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result notification = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool _disposed = false;
  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter();
    notification = await EcoBinApi()
        .getNotify(ResultArguments(filter: filter, offset: offset));
    if (!_disposed) {
      setState(() {
        isLoading = false;
      });
    }
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

  showNotDialog(BuildContext context, TrashNotification data) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              '${data.title}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Container(
            child: Text('${data.body}'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  onTap(String id) async {
    try {
      trash = await EcoBinApi().getNotifyItem(id);
      showNotDialog(context, trash);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Row(
          children: [
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                'assets/svg/back_arrow.svg',
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Мэдэгдэл',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: greytext,
      body: notification.rows?.length != 0
          ? Refresher(
              refreshController: refreshController,
              onLoading: notification.rows!.length == notification.count
                  ? null
                  : onLoading,
              onRefresh: onRefresh,
              color: greentext,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: notification.rows!
                          .map((data) => NotificationCard(
                                data: data,
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    NotificationDetailPage.routeName,
                                    arguments: NotificationDetailPageArguments(
                                      data: data,
                                    ),
                                  );
                                },
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
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
    );
  }
}
