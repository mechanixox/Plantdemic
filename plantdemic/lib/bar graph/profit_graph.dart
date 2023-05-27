import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfitGraph extends StatelessWidget {
  const ProfitGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      maxY: 100,
      minY: 0,
    ));
  }
}
