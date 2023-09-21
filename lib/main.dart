import 'package:discuss_app/config/app.color.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/controller/c_account.dart';
import 'package:discuss_app/controller/c_explore.dart';
import 'package:discuss_app/controller/c_feed.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Biar ga erorr
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Didaftarin
        ChangeNotifierProvider(create: (_) => CUser()),
        ChangeNotifierProvider(create: (_) => CHome()),
        ChangeNotifierProvider(create: (_) => CFeed()),
        ChangeNotifierProvider(create: (_) => CExplore()),
        ChangeNotifierProvider(create: (_) => CMyTopic()),
        ChangeNotifierProvider(create: (_) => CAccount()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 0, 119, 255),
          colorScheme: ColorScheme.light().copyWith(
            primary: AppColor.primay,
          ),
        ),
        routerConfig: AppRoute.routerConfig,
      ),
    );
  }
}
