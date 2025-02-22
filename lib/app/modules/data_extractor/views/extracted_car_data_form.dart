import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/data_extractor/controllers/data_extractor_controller.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/vehicle_card.dart';
import 'package:ui_challenge/app/widgets/custom_button.dart';

class ExtractedCarDataForm extends GetWidget<DataExtractorController> {
  final VehicleCard vehicleCard;

  const ExtractedCarDataForm({super.key, required this.vehicleCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Data'),
        centerTitle: true,
        // surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        // bottom: LinearProgressIndicator(),
      ),
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.selectedVehicleCard.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: ListView(
            controller: controller.scrollController,
            padding: EdgeInsets.symmetric(vertical: 10),
            children: [
              _buildTextField('Card Type', vehicleCard.type),
              _buildTextField('Brand', vehicleCard.brand),
              _buildTextField('Number', vehicleCard.number),
              _buildTextField('Gender', vehicleCard.gender),
              _buildTextField('Model', vehicleCard.model),
              _buildTextField('Owner', vehicleCard.owner),
              _buildTextField('Body', vehicleCard.body),
              _buildTextField('Color', vehicleCard.color),
              _buildTextField('Energy', vehicleCard.energy),
              _buildTextField('Usage', vehicleCard.usage),
              _buildTextField(
                  'Seating Capacity', vehicleCard.seatingCapacity.toString()),
              _buildTextField('Power', vehicleCard.power.toString()),
              _buildTextField('Axles Count', vehicleCard.axlesCount.toString()),
              // _buildSignatureSection(vehicleCard.signature),
              // _buildListView(
              //     'Mésure de sécurité', vehicleCard.securityFeatures!),
              _buildTextField('Remarks', vehicleCard.remarks),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: CustomButton(
          title: "Save",
          isLoading: controller.isSaving.value,
          onTap: () {
            controller.savaExtractedVehicleData();
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? value) {
    if (value == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor:
              const Color.fromARGB(255, 198, 227, 165).withValues(alpha: .1),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        controller: TextEditingController(text: value),
        readOnly: true,
      ),
    );
  }
}
