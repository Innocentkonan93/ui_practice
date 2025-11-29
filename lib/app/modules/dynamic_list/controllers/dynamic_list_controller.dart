import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/dynamic_list/models/contact_model.dart';

class DynamicListController extends GetxController {
  // Contrôleurs de champs de texte pour les formulaires

  RxList<ContactModel> filteredContacts = <ContactModel>[].obs;
  RxnInt selectedIndex = RxnInt();
  RxnInt selectedContactIndex = RxnInt();
  final selectedPageIndex = 0.obs;

  final listLength = 16.obs;

  final Map<String, String> keypadMap = {
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
  };

  String convertNumberToRegex(String number) {
    return number.split('').map((digit) {
      final letters = keypadMap[digit];
      return letters != null ? '[$letters]' : digit;
    }).join('');
  }

  void searchContact(String q) {
    print(q);

    if (q.isEmpty) {
      filteredContacts([]);
      return;
    }
    if (q.contains('+')) {
      filteredContacts(
        contacts
            .where(
              (e) => e.phoneNumber.contains(q),
            )
            .toList(),
      );
    } else {
      final regexPattern =
          RegExp(convertNumberToRegex(q), caseSensitive: false);

      filteredContacts(
        contacts
            .where(
              (e) => regexPattern.hasMatch(e.name) || e.phoneNumber.contains(q),
            )
            .toList(),
      );
    }
    update();
  }
}
