import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/controllers/avanced_chat_ui_controller.dart';

class ReceiverStatusBar extends GetWidget<AvancedChatUiController> {
  const ReceiverStatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedReceiver = controller.selectedReceiver.value;
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.051),
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chevron_left,
                  size: 30,
                )),
            Expanded(
              flex: 2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-2.0, 0.0), // slide from left
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                switchInCurve: Curves.decelerate,
                switchOutCurve: Curves.decelerate,
                child: Row(
                  key: ValueKey(selectedReceiver?.id),
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/avatars/${selectedReceiver?.avatar}.png',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedReceiver?.name ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.circle,
                                size: 10,
                                color: selectedReceiver?.isOnline ?? false
                                    ? Colors.green
                                    : Colors.red),
                            const SizedBox(width: 5),
                            Text(
                              selectedReceiver?.isOnline ?? false
                                  ? "Online"
                                  : "Offline",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: selectedReceiver?.isOnline ?? false
                                          ? Colors.green
                                          : Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.phone,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 20,
              ),
            ),
          ],
        ),
      );
    });
  }
}
