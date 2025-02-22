import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kki_list_controller.dart';

class KkiListView extends GetView<KkiListController> {
  const KkiListView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('KkiListView'),
      //   centerTitle: true,
      // ),
      body: Obx(() {
        if (controller.selectedIndex.value < 0) {
          return Text('Select a KKI');
        }
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Row(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (value) {
                    double newOffset = controller.scrollController.offset;
                    double maxScroll =
                        controller.scrollController.position.maxScrollExtent;
                    double minScroll =
                        controller.scrollController.position.minScrollExtent;

                    if (value > controller.previousIndex.value) {
                      // Page avancée -> Scroller vers le bas (+50 px)
                      newOffset += 50;
                    } else {
                      // Page reculée -> Scroller vers le haut (-50 px)
                      newOffset -= 50;
                    }

                    // Vérifier si on est dans les limites avant d'animer le scroll
                    if (newOffset >= minScroll && newOffset <= maxScroll) {
                      controller.scrollController.animateTo(
                        newOffset,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }

                    // Mettre à jour l'index précédent
                    controller.previousIndex(value);
                    controller.selectedIndex(value);
                  },
                  itemCount: controller.rainbowColors.length,
                  itemBuilder: (context, index) {
                    final colorInfo = controller.rainbowColors[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: colorInfo.color,
                      ),
                      child: Center(child: Text(colorInfo.shade.toString())),
                    );
                  },
                ),
              ),
              Container(
                height: size.height,
                width: size.width * .35,
                child: ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.rainbowColors.length,
                  itemBuilder: (context, index) {
                    final colorInfo = controller.rainbowColors[index];
                    return GestureDetector(
                      onTap: () {
                        controller.scrollToIndex(index);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorInfo.color,
                          border: controller.selectedIndex.value == index
                              ? Border.all()
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            colorInfo.shade.toString(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
