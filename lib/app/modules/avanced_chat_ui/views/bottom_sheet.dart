import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/controllers/avanced_chat_ui_controller.dart';
import 'package:waveform_recorder/waveform_recorder.dart';

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
        return Obx(() => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: controller.isRecording.value
                    ? AppColors.purple
                    : Colors.blue,
                border: Border(
                  top: BorderSide(
                    color: Colors.black12,
                    width: 1.4,
                  ),
                ),
              ),
              constraints: BoxConstraints(
                minHeight: bottomSheetHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (!controller.isRecording.value)
                        IconButton(
                          onPressed: () {
                            controller.showMenu.value = true;
                            controller.update();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(30, 30),
                          ),
                        ),
                      Expanded(
                        child: controller.isRecording.value
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: WaveformRecorder(
                                  height: 40,
                                  controller: controller.waveformRecorder,
                                  waveColor: Colors.white,
                                  durationTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  onRecordingStopped: () {
                                    controller.isRecordingPause.value = false;
                                    controller.update();
                                  },
                                ),
                              ).animate().fadeIn()
                            : TextFormField(
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
                                  controller.scrollToBottom();
                                  controller.update();
                                },
                                minLines: 1,
                                maxLines: 2,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: const TextStyle(color: Colors.white),
                              ),
                      ),
                      if (!controller.focusNode.value.hasFocus &&
                          !controller.isRecording.value)
                        IconButton(
                          onPressed: () {
                            controller.startRecording();
                          },
                          icon: Icon(
                            Icons.mic,
                            color: AppColors.white,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(30, 30),
                          ),
                        ),
                      if (controller.focusNode.value.hasFocus)
                        IconButton.filledTonal(
                          onPressed: () {
                            controller.sendText();
                          },
                          icon: Icon(
                            Icons.send,
                            color: AppColors.purple,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(30, 30),
                          ),
                        ).animate().fadeIn(),
                    ],
                  ),
                  Obx(() => controller.isRecording.value
                      ? SafeArea(
                          child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.deleteRecording();
                                },
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.toggleRecording();
                                },
                                icon: Icon(controller.isRecordingPause.value
                                    ? Icons.mic
                                    : Icons.stop),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.stopRecording(send: true);
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn())
                      : const SizedBox.shrink()),
                ],
              ),
            ));
      },
    );
  }
}
