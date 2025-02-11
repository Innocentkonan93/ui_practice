import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}

String extractJson(String input) {
  final regex = RegExp(r'```json\n?({.*})\n?```');
  final match = regex.firstMatch(input);
  if (match != null) {
    return match.group(1) ?? '';
  }
  return '';
}

void showSnackbar(String text, [bool isSuccess = false]) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.white),
      ),
      backgroundColor: isSuccess ? AppColors.lightGreen : AppColors.red,
    ),
  );
}
