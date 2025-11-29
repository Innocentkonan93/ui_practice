import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';

import '../controllers/page_transition_controller.dart';

class PageTransitionView extends GetView<PageTransitionController> {
  const PageTransitionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageTransitionView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.size.width * .7,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PageView(
                          controller: controller.pageController,
                          pageSnapping: true,
                          restorationId: "page_view",
                          onPageChanged: (index) {
                            controller.currentPage.value = index;
                          },
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        // color: AppColors.grey,
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          3,
                          (index) => InkWell(
                            onTap: () {
                              controller.pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            onHover: (value) {
                              controller.onHover(value, index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: controller.currentPage.value == index
                                    ? AppColors.orange
                                    : AppColors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text("Moi $index"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
