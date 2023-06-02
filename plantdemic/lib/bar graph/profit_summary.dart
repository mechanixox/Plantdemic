import 'package:flutter/material.dart';
import 'package:plantdemic/bar%20graph/profit_graph.dart';

import 'package:plantdemic/models/plantdemic.dart';
import 'package:plantdemic/components/date_time_helper.dart';
import 'package:provider/provider.dart';

import '../pages/all_summary.dart';

class ProfitSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ProfitSummary({super.key, required this.startOfWeek});

  //calculating for maxY in y-axis
  double calculateMax(
    Plantdemic value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 1000;

    List<double> values = [
      value.calculateDailyProfitSummary()[sunday] ?? 0,
      value.calculateDailyProfitSummary()[monday] ?? 0,
      value.calculateDailyProfitSummary()[tuesday] ?? 0,
      value.calculateDailyProfitSummary()[wednesday] ?? 0,
      value.calculateDailyProfitSummary()[thursday] ?? 0,
      value.calculateDailyProfitSummary()[friday] ?? 0,
      value.calculateDailyProfitSummary()[saturday] ?? 0,
    ];

    //sort from smallest to largest
    values.sort();

    max = values.last * 1.1;
    return max == 0 ? 0 : max;
  }

  String calculateWeekTotal(
    Plantdemic value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyProfitSummary()[sunday] ?? 0,
      value.calculateDailyProfitSummary()[monday] ?? 0,
      value.calculateDailyProfitSummary()[tuesday] ?? 0,
      value.calculateDailyProfitSummary()[wednesday] ?? 0,
      value.calculateDailyProfitSummary()[thursday] ?? 0,
      value.calculateDailyProfitSummary()[friday] ?? 0,
      value.calculateDailyProfitSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  void goToAllSummary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllSummary()),
    );
  }

  @override
  Widget build(BuildContext context) {
    //mm dd yyyy
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<Plantdemic>(
        builder: (context, value, child) => Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Row(
                      children: [
                        Text(
                          'Weekly Profit Summary',
                          style: TextStyle(
                            fontSize: 18,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => goToAllSummary(context),
                          child: Text(
                            'View all',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sell_outlined,
                        size: 20,
                      ),
                      /*Text(
                        'Total: ',
                        style: TextStyle(
                          fontSize: 17,
                          //color: Colors.green.shade600,
                        ),
                      ),*/
                      Text(
                        ' ₱${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          //color: Colors.green.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 230,
                  child: ProfitGraph(
                    maxY: calculateMax(value, sunday, monday, tuesday,
                        wednesday, thursday, friday, saturday),
                    sunAmount: value.calculateDailyProfitSummary()[sunday] ?? 0,
                    monAmount: value.calculateDailyProfitSummary()[monday] ?? 0,
                    tueAmount:
                        value.calculateDailyProfitSummary()[tuesday] ?? 0,
                    wedAmount:
                        value.calculateDailyProfitSummary()[wednesday] ?? 0,
                    thuAmount:
                        value.calculateDailyProfitSummary()[thursday] ?? 0,
                    friAmount: value.calculateDailyProfitSummary()[friday] ?? 0,
                    satAmount:
                        value.calculateDailyProfitSummary()[saturday] ?? 0,
                  ),
                ),
              ],
            ));
  }
}
