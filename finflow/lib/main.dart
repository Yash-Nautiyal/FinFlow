import 'package:finflow/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen()),
    );
  }
}
