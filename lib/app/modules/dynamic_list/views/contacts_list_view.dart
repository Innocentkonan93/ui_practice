import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/dynamic_list/controllers/dynamic_list_controller.dart';
import 'package:ui_challenge/app/modules/dynamic_list/models/contact_model.dart';

class ContactsListView extends GetWidget<DynamicListController> {
  const ContactsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text('Contacts'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(child: Icon(Icons.filter_list)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(child: Icon(Icons.search)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(child: Icon(Icons.more_vert)),
          ),
        ],
      ),
      body: GetBuilder(
          init: DynamicListController(),
          builder: (context) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  contacts.sort(
                    (a, b) => a.name.compareTo(b.name),
                  );
                  final contact = contacts[index];
                  final isSelected =
                      controller.selectedContactIndex.value == index;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        if (controller.selectedContactIndex.value == index) {
                          controller.selectedContactIndex.value = null;
                        } else {
                          controller.selectedContactIndex(index);
                        }
                        controller.update();
                      },
                      child: AnimatedContainer(
                        height: isSelected ? 130 : 40,
                        duration: Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: !isSelected
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.purple,
                                      radius: 15,
                                      child: CircleAvatar(
                                        radius: 14,
                                        child: Text(
                                            "${contact.name.substring(0, 1)}"),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: !isSelected
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${contact.name}",
                                            style: theme.textTheme.titleMedium,
                                          ),
                                          if (isSelected)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${contact.phoneNumber}",
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton.filledTonal(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.call),
                                                    ),
                                                    IconButton.filledTonal(
                                                      onPressed: () {},
                                                      icon: Icon(Icons
                                                          .chat_bubble_outlined),
                                                    ),
                                                    IconButton.filledTonal(
                                                      onPressed: () {},
                                                      icon: Icon(Icons
                                                          .video_call_rounded),
                                                    ),
                                                    IconButton.filledTonal(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.info),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                SizedBox(
                                  height: 5,
                                ),
                              if (isSelected)
                                Divider(
                                  height: 5,
                                  color: theme.scaffoldBackgroundColor,
                                ),
                              if (!isSelected)
                                Divider(
                                  height: 5,
                                  indent: 35,
                                  color: theme.scaffoldBackgroundColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
