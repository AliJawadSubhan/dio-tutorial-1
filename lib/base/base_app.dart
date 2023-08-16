import 'package:dio_course/home/home.dart';
import 'package:flutter/material.dart';

class DioApplication extends StatelessWidget {
  const DioApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
