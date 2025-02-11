import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appTheme,
    );
  }
}
