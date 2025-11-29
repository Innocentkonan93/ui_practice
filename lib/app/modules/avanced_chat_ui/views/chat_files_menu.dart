import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/controllers/avanced_chat_ui_controller.dart';
import 'package:ui_challenge/app/utils/constantes.dart';

class ChatFilesMenu extends GetWidget<AvancedChatUiController> {
  const ChatFilesMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvancedChatUiController>(builder: (controller) {
      if (controller.selectedImages.isNotEmpty) {
        return Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(Icons.photo_library_outlined, color: AppColors.purple),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.selectedImages.length} fichier${controller.selectedImages.length > 1 ? "s" : ""} sélectionné${controller.selectedImages.length > 1 ? "s" : ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              IconButton.filledTonal(
                onPressed: () {
                  controller.selectedImages.clear();
                  controller.update();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.resolveWith(
                    (states) => Colors.red.withValues(alpha: 0.2),
                  ),
                  foregroundColor: WidgetStateColor.resolveWith(
                    (states) => Colors.red,
                  ),
                ),
                icon: Icon(Icons.delete_forever),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: () {
                  controller.sendFiles();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.resolveWith(
                    (states) => AppColors.purple.withValues(alpha: 0.2),
                  ),
                  foregroundColor: WidgetStateColor.resolveWith(
                    (states) => AppColors.purple,
                  ),
                ),
                icon: Icon(Icons.send_rounded),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(
              duration: Duration(milliseconds: 300),
            )
            .slideY(
              begin: 0.4,
              end: 0,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
            );
      }
      return SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              menu.length,
              (index) {
                Map<String, dynamic> item = menu[index];
                return Container(
                  width: 90,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectedMenu.value = item['id'];
                          controller.update();
                        },
                        child: AnimatedContainer(
                          duration: Duration(
                            milliseconds: 300,
                          ),
                          height: 80,
                          width: double.infinity,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: controller.selectedMenu.value == item['id']
                                ? AppColors.purple
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            item['icon'],
                            color: controller.selectedMenu.value == item['id']
                                ? AppColors.white
                                : AppColors.purple,
                          ),
                        ),
                      ),
                      Text(
                        item['name'],
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
