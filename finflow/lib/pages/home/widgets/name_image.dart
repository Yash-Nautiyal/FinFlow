import 'dart:math';

import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

Future<Center> username(double Size) async {
  final name = await retrieveData("Name");
  return Center(
    child: Initicon(
        text: name.toString(),
        size: Size,
        backgroundColor: niceColors[Random().nextInt(niceColors.length - 1)]),
  );
}

FutureBuilder nameimage(double size) {
  return FutureBuilder<Center>(
      future: username(size),
      builder: (BuildContext context, AsyncSnapshot<Center?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return snapshot.data ?? Center(child: Text('No data'));
        }
      });
}
