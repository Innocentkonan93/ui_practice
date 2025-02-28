import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/dynamic_list/controllers/dynamic_list_controller.dart';
import 'package:ui_challenge/app/modules/dynamic_list/models/call_log_model.dart';
import 'package:ui_challenge/app/utils/utils.dart';

class CallLogsView extends GetWidget<DynamicListController> {
  const CallLogsView({
    super.key,
  });

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
          return ListView.builder(
            itemBuilder: (context, index) {
              final callLog = dummyCallLogs[index];
              final isSelected = controller.selectedIndex.value == index;
              return Slidable(
                key: ValueKey(index),
                startActionPane: isSelected
                    ? null
                    : ActionPane(
                        motion: ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: AppColors.lightGreen,
                            foregroundColor: Colors.white,
                            icon: Icons.call,
                            label: 'Appeler',
                          ),
                        ],
                      ),
                // The end action pane is the one at the right or the bottom side.
                endActionPane: isSelected
                    ? null
                    : ActionPane(
                        motion: ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        // dragDismissible: false,
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.chat_bubble_rounded,
                            label: 'Écrire',
                            spacing: 0,
                          ),
                        ],
                      ),
                child: Padding(
                  padding: isSelected
                      ? EdgeInsets.symmetric(vertical: 7)
                      : EdgeInsets.zero,
                  child: InkWell(
                    onTap: () {
                      if (controller.selectedIndex.value == index) {
                        controller.selectedIndex.value = null;
                      } else {
                        controller.selectedIndex(index);
                      }
                      controller.update();
                    },
                    splashColor: Colors.transparent,
                    child: AnimatedContainer(
                      height: isSelected
                          ? callLog.isSavedContact
                              ? 180
                              : 230
                          : 60,
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
                              decoration: BoxDecoration(
                                color: AppColors.white,
                              ),
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
                                      "${callLog.contactName}",
                                      style: isSelected
                                          ? theme.textTheme.titleLarge
                                          : theme.textTheme.titleMedium,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Visibility(
                                    visible: !isSelected,
                                    replacement: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: AppColors.black,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Visibility(
                                          visible: !callLog.isSavedContact,
                                          replacement: Text(
                                            "${callLog.contactName.substring(0, 1)}",
                                          ),
                                          child: Icon(
                                            Icons.person_add_alt_1_rounded,
                                          ),
                                        ),
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
                                          color: switch (callLog.simSlot) {
                                            1 => AppColors.purple,
                                            2 => const Color.fromARGB(
                                                255, 56, 96, 10),
                                            _ => null,
                                          },
                                        ),
                                        Text(
                                          DateFormat(
                                            "HH:mm",
                                            "fr_FR", // Ajoute cette locale pour les mois en français
                                          ).format(callLog.callDate),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "Mobile ${callLog.phoneNumber}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                switch (callLog.callType) {
                                                  CallType.incoming =>
                                                    "Appel entrant,",
                                                  CallType.missed =>
                                                    "Appel manqué,",
                                                  CallType.outgoing =>
                                                    "Appel sortant,",
                                                  CallType.rejected =>
                                                    "Appel rejeté,",
                                                },
                                                style:
                                                    theme.textTheme.labelSmall,
                                              ),
                                              SizedBox(width: 3),
                                              Text(
                                                formatDuration(
                                                    callLog.callDuration),
                                                style:
                                                    theme.textTheme.labelSmall,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                DateFormat(
                                                  "HH:mm",
                                                  "fr_FR", // Ajoute cette locale pour les mois en français
                                                ).format(callLog.callDate),
                                              ),
                                              Icon(
                                                Icons.sim_card_rounded,
                                                size: 12,
                                                color: switch (
                                                    callLog.simSlot) {
                                                  1 => AppColors.purple,
                                                  2 => const Color.fromARGB(
                                                      255, 56, 96, 10),
                                                  _ => null,
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
                                          icon:
                                              Icon(Icons.chat_bubble_outlined),
                                        ),
                                        IconButton.filledTonal(
                                          onPressed: () {},
                                          icon: Icon(Icons.video_call_rounded),
                                        ),
                                        IconButton.filledTonal(
                                          onPressed: () {},
                                          icon: Icon(Icons.list_rounded),
                                        ),
                                      ],
                                    ),
                                    if (!callLog.isSavedContact)
                                      Column(
                                        children: [
                                          SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            height: 50,
                                            padding: EdgeInsets.only(top: 5),
                                            decoration: BoxDecoration(
                                                color: theme
                                                    .scaffoldBackgroundColor),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: SizedBox.expand(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.add),
                                                          Text(
                                                              "Ajouter au contacts")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: SizedBox.expand(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.tag),
                                                          Text("Ajouter tag")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                )
                                    .animate()
                                    .fadeIn(delay: Duration(milliseconds: 200)),
                              ),
                            // if (callLog.isSavedContact)
                            //   Container(
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       color: AppColors.purple,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: dummyCallLogs.length,
          );
        },
      ),
    );
  }
}
