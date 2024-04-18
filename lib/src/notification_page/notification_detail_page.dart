import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_bin_flutter/models/trash_notification.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class NotificationDetailPageArguments {
  TrashNotification data;

  NotificationDetailPageArguments({
    required this.data,
  });
}

class NotificationDetailPage extends StatefulWidget {
  static const routeName = "NotificationDetailPage";
  final TrashNotification data;

  const NotificationDetailPage({super.key, required this.data});

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
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
        titleSpacing: 80,
        title: Text(
          'Дэлгэрэнгүй',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.data.title}',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '${widget.data.body}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
