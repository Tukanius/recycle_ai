import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class InfoCard extends StatefulWidget {
  final String svg;
  final String type;
  final int? number;

  const InfoCard({
    super.key,
    required this.svg,
    required this.type,
    this.number,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(widget.svg),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.type,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              widget.number == null ? '0' : "${widget.number}",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            Text(
              'Ширхэг',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
