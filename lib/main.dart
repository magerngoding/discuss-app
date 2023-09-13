import 'package:discuss_app/config/app.color.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:flutter/material.dart';

void main() {
  // Biar ga erorr
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 119, 255),
        colorScheme: ColorScheme.light().copyWith(
          primary: AppColor.primay,
        ),
      ),
      routerConfig: AppRoute.routerConfig,
    );
  }
}
