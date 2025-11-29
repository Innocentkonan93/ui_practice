import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/controllers/avanced_chat_ui_controller.dart';
import 'package:ui_challenge/app/utils/constantes.dart';

class CustomBottomSheet extends GetWidget<AvancedChatUiController> {
  const CustomBottomSheet({
    super.key,
    required this.bottomSheetHeight,
  });

  final double bottomSheetHeight;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvancedChatUiController>(
      init: AvancedChatUiController(),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.blue,
            border: Border(
              top: BorderSide(
                color: Colors.black12,
                width: 1.4,
              ),
            ),
          ),
          height: bottomSheetHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.messageController,
                      focusNode: controller.focusNode.value,
                      decoration: const InputDecoration(
                        hintText: 'Type message...',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      onTap: () {
                        controller.update();
                      },
                      minLines: 1,
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  if (!controller.focusNode.value.hasFocus)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          controller.showMenu.value = true;
                          controller.update();
                        },
                        child: const Icon(
                          Icons.file_present_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (!controller.focusNode.value.hasFocus)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.mic,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (controller.focusNode.value.hasFocus)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton.filledTonal(
                        onPressed: () {
                          controller.sendText();
                        },
                        icon:
                            Icon(Icons.send, size: 20, color: AppColors.purple),
                      ),
                    ),
                ],
              ),
              // SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
