import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/auth_ui/controllers/auth_ui_controller.dart';
import 'package:ui_challenge/app/routes/app_pages.dart';

class HomeScreen extends GetView<AuthUiController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () {
              Get.offAllNamed(Routes.AUTH_UI);
            },
          ),
        ],
      ),
      body: Center(child: Text('Home Screen')),
    );
  }
}
