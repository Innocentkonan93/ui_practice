import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/dynamic_list/controllers/dynamic_list_controller.dart';
// import 'package:url_launcher/url_launcher.dart';

class CallsKeyboardView extends GetWidget<DynamicListController> {
  final RxString phoneNumber = ''.obs;

  final Map<String, String> buttons = {
    '1': '',
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
    '*': '',
    '0': '+',
    '#': ''
  };

  CallsKeyboardView({Key? key}) : super(key: key);

  void onButtonPressed(String value) {
    phoneNumber.value += value;
    controller.searchContact(phoneNumber.value);
  }

  void clear() {
    if (phoneNumber.isNotEmpty) {
      phoneNumber.value =
          phoneNumber.substring(0, phoneNumber.value.length - 1);
    }
    if (phoneNumber.value.length == 0) {
      controller.filteredContacts([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  ...List.generate(
                    controller.filteredContacts.take(3).length,
                    (index) {
                      final contact = controller.filteredContacts[index];
                      return Row(
                        children: [
                          Text(
                            contact.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(contact.phoneNumber),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Text(
              phoneNumber.value,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                String text = buttons.keys.elementAt(index);
                String? subtext = buttons[text];

                return GestureDetector(
                  onTap: () {
                    if (text == '📞') {
                      // makeCall();
                    } else {
                      onButtonPressed(text);
                    }
                  },
                  onLongPress: () {
                    if (text == '0') {
                      onButtonPressed(subtext!);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: text == '📞' ? Colors.green : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: text == '📞'
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: text == '📞' ? Colors.white : Colors.black,
                          ),
                        ),
                        if (subtext != null && subtext.isNotEmpty)
                          Text(
                            subtext,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.7,
              ),
              children: [
                SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.call_rounded,
                    size: 30,
                    color: AppColors.white,
                  ),
                ),
                GestureDetector(
                  onLongPress: () {
                    phoneNumber.value = '';
                    controller.filteredContacts([]);
                  },
                  onTap: () {
                    clear();
                  },
                  child: Container(
                    child: Center(
                      child: phoneNumber.isEmpty
                          ? SizedBox.shrink()
                          : Icon(Icons.backspace),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
              child: Visibility(
                visible: phoneNumber.value.isNotEmpty,
                child: Chip(
                  label: Text("Sim 1"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
