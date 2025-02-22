import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';

import '../controllers/dynamic_list_controller.dart';

class DynamicListView extends GetWidget<DynamicListController> {
  const DynamicListView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text('Téléphone'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.filter_list),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: GetBuilder(
        init: DynamicListController(),
        builder: (controller) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox.expand(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectedIndex.value == index;
                    return Padding(
                      padding: isSelected
                          ? EdgeInsets.symmetric(vertical: 7)
                          : EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          controller.selectedIndex(index);
                          controller.update();
                        },
                        splashColor: Colors.transparent,
                        child: AnimatedContainer(
                          height: isSelected ? 200 : 60,
                          duration: Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isSelected)
                                  Divider(
                                    indent: 50,
                                    endIndent: 20,
                                    height: 0,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Row(
                                    children: [
                                      if (!isSelected)
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Icon(Icons.call),
                                              width: 30,
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      Expanded(
                                        child: Text(
                                          "+225 0749566561",
                                          style: isSelected
                                              ? theme.textTheme.titleLarge
                                              : theme.textTheme.titleMedium,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Visibility(
                                        visible: !isSelected,
                                        replacement: CircleAvatar(
                                          radius: 25,
                                          child: Icon(
                                            Icons.person_add_alt_1_rounded,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.sim_card_rounded,
                                              size: 15,
                                            ),
                                            Text("22:34"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("Mobile +225 0749566561"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Appel sortant, 1 min 36",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("22:34"),
                                            Icon(
                                              Icons.sim_card_rounded,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton.filledTonal(
                                              onPressed: () {},
                                              icon: Icon(Icons.call),
                                            ),
                                            IconButton.filledTonal(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.chat_bubble_outlined),
                                            ),
                                            IconButton.filledTonal(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.video_call_rounded),
                                            ),
                                            IconButton.filledTonal(
                                              onPressed: () {},
                                              icon: Icon(Icons.list_rounded),
                                            ),
                                          ],
                                        )
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 200)),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.listLength.value,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.keyboard),
            label: "Clavier",
          ),
          NavigationDestination(
            icon: Icon(Icons.keyboard),
            label: "Clavier",
          ),
          NavigationDestination(
            icon: Icon(Icons.keyboard),
            label: "Clavier",
          ),
        ],
      ),
    );
  }
}
