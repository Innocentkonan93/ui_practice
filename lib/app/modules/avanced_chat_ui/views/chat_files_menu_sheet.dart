import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ui_challenge/app/modules/avanced_chat_ui/controllers/avanced_chat_ui_controller.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/views/chat_camera_view.dart';
import 'package:ui_challenge/app/utils/constantes.dart';

class ChatFilesMenuSheet extends StatelessWidget {
  const ChatFilesMenuSheet({
    super.key,
    this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    return GetBuilder<AvancedChatUiController>(builder: (controller) {
      return DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.45,
        maxChildSize: 0.9,
        snap: true,
        snapSizes: const [0.45, 0.7, 0.9],
        controller: controller.draggableScrollableController,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: Text(
                        title ?? "Galerie",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        controller.showMenu.value = false;
                        controller.update();
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(4),
                    child: IndexedStack(
                      index: controller.selectedMenu.value,
                      children: [
                        // image section
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: .65,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          // physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          itemCount: gallery.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (controller.selectedImages.contains(
                                    gallery[index]['id'].toString())) {
                                  controller.selectedImages
                                      .remove(gallery[index]['id'].toString());
                                  controller.selectedImagesPaths.remove(
                                      gallery[index]['image'].toString());
                                } else {
                                  controller.selectedImages
                                      .add(gallery[index]['id'].toString());
                                  controller.selectedImagesPaths
                                      .add(gallery[index]['image'].toString());
                                }
                                controller.update();
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: ShapeDecoration(
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  shape: RoundedSuperellipseBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        gallery[index]['image'] as String),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Icon(
                                      controller.selectedImages.contains(
                                              gallery[index]['id'].toString())
                                          ? Icons.check_circle_rounded
                                          : Icons.circle_outlined,
                                      color: controller.selectedImages.contains(
                                              gallery[index]['id'].toString())
                                          ? Colors.green
                                          : Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.7,
                          child: ChatCameraView(),
                        ),
                        Container(
                          color: Colors.blue,
                          child: Text('Contact'),
                        ),
                        Container(
                          color: Colors.green,
                          child: Text('Files'),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(child: SizedBox(height: 65)),
              ],
            ),
          );
        },
      );
    });
  }
}
