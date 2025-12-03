import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/avanced_chat_ui_controller.dart';

class ChatCameraView extends GetView<AvancedChatUiController> {
  const ChatCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return controller.isCameraInitialized.value
              ? CameraPreview(controller.cameraController)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
