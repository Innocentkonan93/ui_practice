import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/dynamic_list/views/call_keyboard_view.dart';
import 'package:ui_challenge/app/modules/dynamic_list/views/call_logs_view.dart';
import 'package:ui_challenge/app/modules/dynamic_list/views/contacts_list_view.dart';

import '../controllers/dynamic_list_controller.dart';

class DynamicListView extends GetWidget<DynamicListController> {
  const DynamicListView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: GetBuilder(
        init: DynamicListController(),
        builder: (controller) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox.expand(
                child: IndexedStack(
                  index: controller.selectedPageIndex.value,
                  children: [
                    CallsKeyboardView(),
                    CallLogsView(),
                    ContactsListView(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          onDestinationSelected: (value) {
            controller.selectedPageIndex(value);
            controller.update();
          },
          selectedIndex: controller.selectedPageIndex.value,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.call),
              label: "Clavier",
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: "Journal",
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: "Contacts",
            ),
          ],
        );
      }),
    );
  }
}
