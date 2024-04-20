import 'package:finflow/pages/stats/bar.dart';
import 'package:finflow/pages/stats/bar2.dart';
import 'package:finflow/pages/stats/pie.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
          child: Column(children: [
            Text(
              'DashBoard',
              style: textTheme.displayMedium!.copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Today's Transactions",
                  style: textTheme.displayMedium!.copyWith(fontSize: 20),
                ),
              ],
            ),
            PieChartSample3(),
            Row(
              children: [
                Text(
                  "Weekly Transactions",
                  style: textTheme.displayMedium!.copyWith(fontSize: 20),
                ),
              ],
            ),
            BarChartSample2(),
            Row(
              children: [
                Text(
                  "Monthly Transactions",
                  style: textTheme.displayMedium!.copyWith(fontSize: 20),
                ),
              ],
            ),
            BarChartSample6(),
          ]),
        ),
      ),
    ));
  }
}
