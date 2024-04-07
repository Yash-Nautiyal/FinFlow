import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';

class PiePage extends StatefulWidget {
  const PiePage({Key? key}) : super(key: key);

  @override
  State<PiePage> createState() => _PiePageState();
}

class _PiePageState extends State<PiePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 300.0,
          maxWidth: 400.0,
        ),
        padding: const EdgeInsets.all(24.0),
        child: Chart(
          layers: layers(),
        ),
      ),
    );
  }

  List<ChartLayer> layers() {
    return [
      ChartGroupPieLayer(
        items: List.generate(
          2,
          (index) => List.generate(
            Random().nextInt(4) + 2,
            (index) => ChartGroupPieDataItem(
                amount: Random().nextInt(300) * Random().nextDouble(),
                color: [
                  Colors.orangeAccent,
                  Colors.pinkAccent,
                  Colors.redAccent,
                  Colors.blueAccent,
                  Colors.cyanAccent,
                  Colors.tealAccent,
                ][Random().nextInt(6)],
                label: [
                  'Life',
                  'Work',
                  'Medicine',
                  'Bills',
                  'Hobby',
                  'Holiday',
                ][Random().nextInt(6)]),
          ),
        ),
        settings: const ChartGroupPieSettings(),
      ),
      ChartTooltipLayer(
        shape: () => ChartTooltipPieShape<ChartGroupPieDataItem>(
          onTextName: (item) => item.label,
          onTextValue: (item) => '€${item.amount.toString()}',
          radius: 10.0,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(12.0),
          nameTextStyle: const TextStyle(
            color: Color(0xFF8043F9),
            fontWeight: FontWeight.w700,
            height: 1.47,
            fontSize: 12.0,
          ),
          valueTextStyle: const TextStyle(
            color: Color(0xFF1B0E41),
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
          ),
        ),
      )
    ];
  }
}
