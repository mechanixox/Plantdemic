import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'bar_data.dart';

class ProfitGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const ProfitGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBarData.initializeBarData();
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: BarChart(BarChartData(
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
          fitInsideVertically: true,
        )),
        maxY: maxY,
        minY: 0,
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
          )),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.green.shade600.withOpacity(0.8),
                      width: 25,
                      borderRadius: BorderRadius.circular(7),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 0,
                        color: Colors.green.shade100,
                      )),
                ]))
            .toList(),
      )),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontSize: 12.5,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
      break;
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thur', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
