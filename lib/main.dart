import 'package:discuss_app/config/app.color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColor.primay,
        colorScheme: ColorScheme.light().copyWith(
          primary: AppColor.primay,
        ),
      ),
      home: Scaffold(),
    );
  }
}
