import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/configs/app_colors.dart';
import 'package:ui_challenge/app/modules/data_extractor/controllers/data_extractor_controller.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/identity_card.dart';
import 'package:ui_challenge/app/widgets/custom_button.dart';

class ExtractedDataForm extends GetWidget<DataExtractorController> {
  final IdentityCard identityCard;

  const ExtractedDataForm({super.key, required this.identityCard});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            _buildTextField('Card Type', identityCard.type),
            _buildTextField('Category', identityCard.drivingLicenseCategory),
            _buildTextField('Country', identityCard.country),
            _buildTextField('Number', identityCard.number),
            _buildTextField('Last Name', identityCard.lastName),
            _buildTextField('First Name', identityCard.firstName),
            _buildTextField('Date of Birth', identityCard.dateOfBirth),
            _buildTextField('Gender', identityCard.gender),
            _buildTextField('Height', identityCard.height),
            _buildTextField('Nationality', identityCard.nationality),
            _buildTextField('Place of Birth', identityCard.placeOfBirth),
            _buildTextField('Expiration Date', identityCard.expirationDate),
            _buildPhotoSection(identityCard.photo),
            _buildSignatureSection(identityCard.signature),
            _buildListView(
                'Mésure de sécurité', identityCard.securityFeatures!),
            _buildTextField('Remarks', identityCard.remarks),
            const SizedBox(height: 20),
            CustomButton(
              title: "Save",
              isLoading: controller.isSaving.value,
              onTap: () {
                controller.savaExtractedData();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? value) {
    if (value == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.lightGreen.withValues(alpha: .1),
          isDense: true,
        ),
        controller: TextEditingController(text: value),
        readOnly: true,
      ),
    );
  }

  Widget _buildPhotoSection(Photo? photo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text(
            'Photo: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: photo?.present == true,
            replacement: const Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: 18,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 18,
            ),
          ),
          Text(photo?.description ?? 'No description'),
        ],
      ),
    );
  }

  Widget _buildSignatureSection(Signature? signature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text(
            'Signature: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: signature?.present == true,
            replacement: const Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: 18,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 18,
            ),
          ),
          Text(signature?.description ?? 'Aucune'),
        ],
      ),
    );
  }

  Widget _buildListView(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ...items.map((item) => Text(item)),
        ],
      ),
    );
  }
}
