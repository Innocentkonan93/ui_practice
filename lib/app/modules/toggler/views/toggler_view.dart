import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';

import '../controllers/toggler_controller.dart';

class TogglerView extends GetView<TogglerController> {
  const TogglerView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // final height = size.height;
    final width = size.width;
    final theme = context.theme;
    final toggleWidth = width / 3.5;
    final toggleHeight = 260.0;
    TextStyle textStyle = theme.textTheme.headlineLarge!
        .copyWith(fontWeight: FontWeight.normal, fontSize: 110);
    return GetBuilder<TogglerController>(
        init: TogglerController(),
        builder: (controller) {
          return Scaffold(
            // backgroundColor:
            //     controller.isOff.value ? Colors.black : Colors.white,
            body: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: controller.isOff.value ? Colors.black : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isOff.value =
                                      !controller.isOff.value;
                                  controller.update();
                                },
                                child: AnimatedContainer(
                                  width: toggleWidth,
                                  height: toggleHeight,
                                  duration: const Duration(milliseconds: 100),
                                  decoration: BoxDecoration(
                                    color: controller.isOff.value
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius:
                                        BorderRadius.circular(toggleWidth / 2),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                bottom: controller.isOff.value
                                    ? 0
                                    : toggleHeight - toggleWidth,
                                width: toggleWidth,
                                height: toggleWidth,
                                duration: const Duration(milliseconds: 400),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.isOff.value =
                                        !controller.isOff.value;
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: controller.isOff.value
                                          ? AppColors.red
                                          : Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: !controller.isOff.value
                                            ? Colors.black
                                            : Colors.white,
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedDefaultTextStyle(
                                child: Text(
                                  "N",
                                ),
                                style: textStyle.copyWith(
                                  color: !controller.isOff.value
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                duration: Duration(milliseconds: 100),
                              ),
                              AnimatedDefaultTextStyle(
                                child: Text(
                                  "FF",
                                ),
                                style: textStyle.copyWith(
                                  color: !controller.isOff.value
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                duration: Duration(milliseconds: 100),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
