import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_bin_flutter/models/initbin.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class HistoryCard extends StatefulWidget {
  final InitBin data;

  const HistoryCard({super.key, required this.data});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.data.type == "PLASTIC"
                  ? SvgPicture.asset('assets/svg/plastic.svg')
                  : SizedBox(),
              widget.data.type == "CAN"
                  ? SvgPicture.asset('assets/svg/can.svg')
                  : SizedBox(),
              widget.data.type == "PAPER"
                  ? SvgPicture.asset('assets/svg/paper.svg')
                  : SizedBox(),
              widget.data.type == "OTHER"
                  ? SvgPicture.asset('assets/svg/other.svg')
                  : SizedBox(),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.type == "PLASTIC"
                        ? 'Хуванцар'
                        : widget.data.type == "CAN"
                            ? 'Лааз'
                            : widget.data.type == "PAPER"
                                ? 'Цаас'
                                : widget.data.type == "OTHER"
                                    ? "Бусад хаягдал"
                                    : '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Үлдэгдэл: ${widget.data.totalAmount} төгрөг',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.data.amount} төгрөг',
                style: TextStyle(
                  color: greentext,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                DateFormat("yyyy-MM-dd HH:mm").format(
                  DateTime.parse(widget.data.createdAt!),
                ),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
