import 'package:finflow/pages/stats/bar.dart';
import 'package:finflow/pages/stats/bar2.dart';
import 'package:finflow/pages/stats/bar3.dart';
import 'package:finflow/pages/stats/line.dart';
import 'package:finflow/pages/stats/line2.dart';
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
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          PiePage(),
          LineChartSample1(),
          BarChartSample2(),
          LineChartSample(),
          BarChartSample6(),
          BarChartSample1(),
        ]),
      ),
    ));
  }
}
