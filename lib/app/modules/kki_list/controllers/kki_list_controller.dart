import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/widgets/rainbow_colors.dart';

class KkiListController extends GetxController {
  late PageController pageController;
  late ScrollController scrollController;

  final previousIndex = 0.obs;
  final selectedIndex = 0.obs;

  final rainbowColors = RainbowColors.generate();
  @override
  void onInit() {
    pageController = PageController();
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void scrollToIndex(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 50),
      curve: Curves.linearToEaseOut,
    );
    selectedIndex.value = index;
  }
}
