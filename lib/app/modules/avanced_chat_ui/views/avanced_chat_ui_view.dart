import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/views/bottom_sheet.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/views/chat_files_menu.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/views/chat_files_menu_sheet.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/views/receiver_status_bar.dart';
import 'package:ui_challenge/app/utils/constantes.dart';

import '../controllers/avanced_chat_ui_controller.dart';
import 'messages_view.dart';

class AvancedChatUiView extends GetView<AvancedChatUiController> {
  const AvancedChatUiView({super.key});

  static final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final bottomSheetHeight = 80.0;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 17, 41),
      body: GetBuilder<AvancedChatUiController>(
        builder: (controller) {
          return SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.resetDrag();
                    FocusScope.of(context).unfocus();
                    controller.update();
                  },
                  behavior: HitTestBehavior.translucent,
                  onVerticalDragUpdate: (details) {
                    controller.handleVerticalDrag(
                      delta: details.delta.dy,
                      screenHeight: screenHeight,
                    );
                  },
                  // onVerticalDragEnd: (_) => controller.resetDrag(),
                  // onVerticalDragCancel: controller.resetDrag,
                  child: Stack(
                    // controller: controller.pageController,
                    // physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    // dragStartBehavior: DragStartBehavior.down,
                    // padEnds: false,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Obx(() {
                                    final receivers = controller.receivers;
                                    return AnimatedList(
                                      key: _animatedListKey,
                                      scrollDirection: Axis.horizontal,
                                      initialItemCount: receivers.length,
                                      itemBuilder: (context, index, animation) {
                                        final receiver = receivers[index];
                                        return SizeTransition(
                                          sizeFactor: animation,
                                          axis: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: GestureDetector(
                                              onTap: () {
                                                final currentIndex = controller
                                                    .receivers
                                                    .indexWhere((r) =>
                                                        r.id == receiver.id);

                                                if (currentIndex > 0) {
                                                  final animatedListState =
                                                      _animatedListKey
                                                          .currentState!;

                                                  // Mettre à jour la liste dans le contrôleur d'abord
                                                  controller
                                                      .selectReceiver(receiver);

                                                  // Supprimer l'élément de sa position actuelle
                                                  animatedListState.removeItem(
                                                    currentIndex,
                                                    (context, animation) {
                                                      return SlideTransition(
                                                        position: Tween<Offset>(
                                                          begin: const Offset(
                                                              0, 0),
                                                          end: const Offset(
                                                              1, 0),
                                                        ).animate(animation),
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 2),
                                                            color: Colors.white,
                                                          ),
                                                          child: ClipOval(
                                                            child: Image.asset(
                                                              "assets/avatars/${receiver.avatar}.png",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                  );
                                                  // Insérer l'élément à l'index 0 après un court délai
                                                  Future.delayed(
                                                    const Duration(
                                                        milliseconds: 450),
                                                    () {
                                                      animatedListState
                                                          .insertItem(
                                                        0,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  // Si déjà à l'index 0, juste sélectionner
                                                  controller
                                                      .selectReceiver(receiver);
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: controller
                                                              .selectedReceiver
                                                              .value
                                                              ?.id ==
                                                          receiver.id
                                                      ? Colors.amber
                                                      : Colors.white,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 2),
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      "assets/avatars/${receiver.avatar}.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          final dragOffset =
                              controller.dragPercent.value * screenHeight;
                          return TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                              begin: 0.0,
                              end: -dragOffset,
                            ),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  child: Scaffold(
                                    body: SizedBox.expand(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: MessagesView(),
                                          ),
                                          const ReceiverStatusBar(),
                                          SizedBox(
                                            height: bottomSheetHeight,
                                          ),
                                        ],
                                      ),
                                    ),
                                    bottomSheet: CustomBottomSheet(
                                      bottomSheetHeight: bottomSheetHeight,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (controller.showMenu.value)
                  ChatFilesMenuSheet(
                    title:
                        menu[controller.selectedMenu.value]['name'] as String,
                  ).animate().slideY(
                        begin: 1,
                        end: 0,
                        duration: Duration(
                          milliseconds: 600,
                        ),
                      ),
                if (controller.showMenu.value)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: Get.size.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: ChatFilesMenu(),
                    ),
                  ).animate().slideY(
                        begin: 1,
                        end: 0,
                        duration: Duration(
                          milliseconds: 300,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
