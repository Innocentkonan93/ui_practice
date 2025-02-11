import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/data_extractor/views/text_detector_view.dart';

import '../controllers/data_extractor_controller.dart';

class DataExtractorView extends GetView<DataExtractorController> {
  const DataExtractorView({super.key});
  @override
  Widget build(BuildContext context) {
    return const TextRecognizerView();
  }
}
