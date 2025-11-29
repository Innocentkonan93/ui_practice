import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTransitionController extends GetxController {
  //TODO: Implement PageTransitionController
  PageController pageController = PageController();

  final currentPage = 0.obs;
  final isHover = false.obs;

  void onHover(bool value, int index) {
    isHover.value = value;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
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

  void increment() => currentPage.value++;
}
