import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_challenge/app/widgets/custom_button.dart';

import '../controllers/data_extractor_controller.dart';

class DataExtractorView extends GetView<DataExtractorController> {
  const DataExtractorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Data Extractor'),
      ),
      body: Center(
        child: Obx(() {
          if (controller.selectedImage.value == null) {
            return const Center(child: Text("Prenez la photo"));
          }
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Image.file(
                    controller.selectedImage.value!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (controller.selectedImage.value != null)
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: CustomButton(
                    isLoading: controller.isAnalyzing.value,
                    onTap: () {
                      controller.analyzeImage();
                    },
                    title: "Analyser",
                  ),
                ),
              const Spacer(),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.pickImage();
        },
        label: const Text('Camera'),
        icon: const Icon(Icons.camera_alt),
      ),
    );
  }
}
