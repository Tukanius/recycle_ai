import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_bin_flutter/components/my_bar_graph/bar_data.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class MyBarGraph extends StatefulWidget {
  final List data;
  const MyBarGraph({Key? key, required this.data}) : super(key: key);

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sun1: widget.data[0],
      sun2: widget.data[1],
      sun3: widget.data[2],
      sun4: widget.data[3],
      sun5: widget.data[4],
      sun6: widget.data[5],
      sun7: widget.data[6],
    );
    myBarData.initBarData();
    return BarChart(
      BarChartData(
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) {
              return greentext;
            },
            tooltipRoundedRadius: 65,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toInt() == 1 ? '0' : '${rod.toY.toInt()}',
                TextStyle(
                  color: white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
          touchCallback:
              (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
            setState(() {
              if (barTouchResponse != null && barTouchResponse.spot != null) {
                selectedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              } else {
                selectedIndex = -1;
              }
            });
          },
        ),
        barGroups: myBarData.barData
            .asMap()
            .entries
            .map(
              (entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.y,
                    color: entry.key == selectedIndex ? greentext : greytext,
                    width: 20,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
