import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/identity_card.dart';
import 'package:ui_challenge/app/modules/data_extractor/views/extracted_data_form.dart';
import 'package:ui_challenge/app/services/gemini_service.dart';
import 'package:ui_challenge/app/services/google_service.dart';
import 'package:ui_challenge/app/utils/utils.dart';

class DataExtractorController extends GetxController {
  final selectedImage = Rx<File?>(null);
  final extractedText = "".obs;

  final isAnalyzing = false.obs;
  final isSaving = false.obs;

  GeminiService geminiService = GeminiService();
  GoogleService googleService = GoogleService();

  final ImagePicker _picker = ImagePicker();

  Rxn<IdentityCard> selectedIdentityCard = Rxn<IdentityCard>();

  /// Sélectionne une image depuis la galerie
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: kDebugMode ? ImageSource.gallery : ImageSource.camera);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      update(); // Met à jour l'UI GetX
    }
  }

  /// Analyse l’image avec un prompt donné
  Future<void> analyzeImage([String? prompt]) async {
    isAnalyzing(true);
    try {
      if (selectedImage.value == null) return;

      final result = await geminiService.analyzeImageWithPrompt(
        selectedImage.value!,
        prompt ??
            """
  Analyse cette image qui sans doute une carte et retourne uniquement les informations en français sous ce format  Map<String, String> sans ajouter d'autres textes:
  {
    "type": "XXXXXX",
    "driving_license_category": "example: A|B|",
    "country": "XXXX",
    "number": "XXXXXXX",
    "last_name": "XXXXX",
    "first_name": "XXXXX",
    "date_of_birth": "DD/MM/YYYY",
    "gender": "X",
    "height": "X.XX",
    "nationality": "XXXX",
    "place_of_birth": "XXXXX",
    "expiration_date": "DD/MM/YYYY",
    "photo": {
      "present": true/false,
      "description": "XXXXX"
    },
    "signature": {
      "present": true/false,
      "description": "XXXXX"
    },
    "security_features": [
      "XXXXX",
      "XXXXX"
    ],
    "remarks": "XXXXX"
  }
  """,
      );
      String jsonString =
          result.text!.replaceAll('```json', '').replaceAll('```', '').trim();

      // Convertir la chaîne JSON en un objet Map
      if (jsonString.isNotEmpty) {
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        print(jsonString);

        IdentityCard identityCard = IdentityCard.fromJson(jsonData);

        showSnackbar("Opération réussie", true);
        isAnalyzing(false);
        selectedIdentityCard(identityCard);
        Get.to(() => ExtractedDataForm(identityCard: identityCard));
        selectedImage.value = null;
      }
    } catch (e) {
      isAnalyzing(false);
      showSnackbar("Une erreur s'est produite", false);
      print(e);
    }
  }

  Future<void> writeToGoogleSheet() async {
    // await googleService.writeToGoogleSheet(selectedIdentityCard.value!.toMap());
    await googleService.authenticateAndWriteToSheet();
  }
}
