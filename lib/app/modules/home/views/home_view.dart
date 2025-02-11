import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.count.value == 100) {
            return const Center(
              child: Text(
                'You have reached the limit of 100 cards',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.withOpacity(.1),
                    child: const Icon(
                      CupertinoIcons.person_alt,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    autofocus: true,
                    cursorOpacityAnimates: true,
                    showCursor: controller.showCursor.value,
                    cursorColor: theme.primaryColor, // Change cursor color
                    cursorHeight: 16,
                    cursorWidth: 1.6 *
                        (controller.enterText.value.length +
                            2), // Change cursor width
                    cursorRadius: Radius.circular(
                      controller.enterText.value.length * 2,
                    ), // Change cursor radius
                    style: theme.textTheme.titleSmall,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: controller.isIconOnRight.value
                              ? theme.colorScheme.primary.withOpacity(.4)
                              : Colors.green.withOpacity(.4),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: controller.isIconOnRight.value
                              ? theme.colorScheme.primary.withOpacity(.4)
                              : Colors.green.withOpacity(.4),
                        ),
                      ),
                      filled: true,
                      fillColor: controller.isIconOnRight.value
                          ? theme.colorScheme.primary.withOpacity(.1)
                          : Colors.green.withOpacity(.1),
                      constraints:
                          const BoxConstraints(maxHeight: 60, maxWidth: 300),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      // labelText: 'Username',
                      hintText: "Your username",
                      isDense: true,
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 100,
                        maxHeight: 40,
                        minHeight: 40,
                      ),
                      suffixIcon: SizedBox(
                        // color: Colors.grey.withOpacity(.2),
                        width: 60,
                        height: 40,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              left: controller.isIconOnRight.value ? -100 : 0,
                              right: controller.isIconOnRight.value ? 0 : -70,
                              top: 0,
                              bottom: 0,
                              child: AnimatedRotation(
                                duration: const Duration(milliseconds: 400),
                                turns: controller.isIconOnRight.value ? -1 : 0,
                                child: Icon(
                                  CupertinoIcons.checkmark_circle_fill,
                                  size: 24,
                                  color: !controller.isIconOnRight.value
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    maxLength: 10,
                    onChanged: (value) {
                      controller.enterText(value);
                      if (value.length == 10) {
                        controller.showCursor(false);
                        controller
                            .isIconOnRight(!controller.isIconOnRight.value);
                      }
                      if (value.length < 10) {
                        controller.showCursor(true);
                        controller.isIconOnRight(true);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !controller.isIconOnRight.value,
                    replacement: const SizedBox(height: 40),
                    child: TextFormField(
                      autofocus: true,
                      cursorOpacityAnimates: true,
                      showCursor: true,
                      cursorColor: Colors.green, // Change cursor color
                      cursorHeight: 16,
                      cursorWidth: 1.6 *
                          (controller.enterText.value.length +
                              2), // Change cursor width
                      cursorRadius: Radius.circular(
                        controller.enterText.value.length * 2,
                      ), // Change cursor radius
                      style: theme.textTheme.titleSmall,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: controller.isIconOnRight.value
                                ? theme.colorScheme.primary.withOpacity(.4)
                                : Colors.green.withOpacity(.4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: controller.isIconOnRight.value
                                ? theme.colorScheme.primary.withOpacity(.4)
                                : Colors.green.withOpacity(.4),
                          ),
                        ),
                        filled: true,
                        fillColor: controller.isIconOnRight.value
                            ? theme.colorScheme.primary.withOpacity(.1)
                            : Colors.green.withOpacity(.1),
                        constraints: const BoxConstraints(
                          maxHeight: 60,
                          maxWidth: 300,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        hintText: 'Password',
                        isDense: true,
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                          minHeight: 40,
                        ),
                      ),

                      obscureText: true,
                      onChanged: (value) {
                        controller.enteredPassword(value);
                        if (value.length >= 8) {
                          controller.isValidated(true);
                        } else {
                          controller.isValidated(false);
                        }
                      },
                    ).animate().scaleY(),
                  ),
                  const SizedBox(height: 30),
                  Visibility(
                    visible: controller.isValidated.value,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: theme.primaryColor,
                      ),
                      child: Text(
                        "Go to go",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ).animate().flipV(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
