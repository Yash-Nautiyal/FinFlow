import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

Glassmorphism? getGlassmorphismConfig(bool isLightTheme) {
  final LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
    stops: const <double>[0.3, 0],
  );

  return isLightTheme
      ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
      : Glassmorphism.defaultConfig();
}
