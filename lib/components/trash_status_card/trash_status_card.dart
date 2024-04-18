import 'package:flutter/material.dart';
import 'package:smart_bin_flutter/components/my_bar_graph/bar_graph.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class TrashStatusCard extends StatefulWidget {
  const TrashStatusCard({super.key});

  @override
  State<TrashStatusCard> createState() => _TrashStatusCardState();
}

class _TrashStatusCardState extends State<TrashStatusCard> {
  List<double> data = [1, 1, 1, 1, 1, 1, 10];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mybarColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Нийт',
            style: TextStyle(
              color: black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '65',
            style: TextStyle(
              color: black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 120,
            child: MyBarGraph(
              data: data,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '1',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '2',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '3',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '4',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '5',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '6',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '7',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
