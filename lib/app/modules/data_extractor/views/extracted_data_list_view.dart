import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/data_extractor/controllers/data_extractor_controller.dart';

class ExtractedDataListView extends GetWidget<DataExtractorController> {
  const ExtractedDataListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Extracted Data List'),
      ),
    );
  }
}
