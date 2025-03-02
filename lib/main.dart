import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_pad_app/screens/HomeScreen.dart';
import 'package:note_pad_app/screens/routes/Routes.dart';
import 'package:note_pad_app/utils/AppColor.dart';

import 'screens/routes/RoutesPages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColor.background
      ),
      getPages: RoutesPages.routes,
      initialRoute: Routes.homeScreen,
    );
  }
}

