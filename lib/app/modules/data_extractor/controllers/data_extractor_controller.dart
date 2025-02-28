import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/identity_card.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/vehicle_card.dart';
import 'package:ui_challenge/app/modules/data_extractor/views/extracted_car_data_form.dart';
import 'package:ui_challenge/app/modules/data_extractor/views/extracted_data_list_view.dart';
import 'package:ui_challenge/app/modules/data_extractor/views/extracted_id_data_form.dart';
import 'package:ui_challenge/app/services/database_helper.dart';
import 'package:ui_challenge/app/services/gemini_service.dart';
import 'package:ui_challenge/app/services/google_service.dart';
import 'package:ui_challenge/app/utils/constantes.dart';
import 'package:ui_challenge/app/utils/utils.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class DataExtractorController extends GetxController {
  final selectedImage = Rx<File?>(null);
  final extractedText = "".obs;

  final isAnalyzing = false.obs;
  final isSaving = false.obs;

  GeminiService geminiService = GeminiService();
  GoogleService googleService = GoogleService();
  DatabaseHelper databaseHelper = DatabaseHelper();
  late ScrollController scrollController;

  final ImagePicker _picker = ImagePicker();

  RxList<IdentityCard> extraxtedIdDataList = <IdentityCard>[].obs;
  RxList<VehicleCard> extractedVehicleDataList = <VehicleCard>[].obs;

  Rxn<IdentityCard> selectedIdentityCard = Rxn<IdentityCard>();
  Rxn<VehicleCard> selectedVehicleCard = Rxn<VehicleCard>();

  /// Sélectionne une image depuis la galerie
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
    );

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
        prompt ?? promptVariable,
      );
      String jsonString =
          result.text!.replaceAll('```json', '').replaceAll('```', '').trim();

      // Convertir la chaîne JSON en un objet Map
      if (jsonString.isNotEmpty) {
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        log(jsonData.toString());
        if (jsonData['type'].toString().toLowerCase() == 'carte grise') {
          // log(jsonData['firstDate'].runtimeType.toString());
          VehicleCard vehicleCard = VehicleCard.fromJson(jsonData);
          // print(vehicleCard.firstDate);
          Get.to(() => ExtractedCarDataForm(vehicleCard: vehicleCard));
          selectedVehicleCard(vehicleCard);
          scrollToBottom();
        } else {
          IdentityCard identityCard = IdentityCard.fromJson(jsonData);
          selectedIdentityCard(identityCard);
          Get.to(() => ExtractedIdentityDataForm(identityCard: identityCard));
          scrollToBottom();
        }
        showSnackbar("Opération réussie", true);
        isAnalyzing(false);
        selectedImage.value = null;
      }
    } catch (e) {
      print(e);
      isAnalyzing(false);
      showSnackbar("Une erreur s'est produite", false);
    }
  }

  Future<void> savaExtractedVehicleData() async {
    isSaving(true);
    // log(selectedVehicleCard.value!.type.toString());
    try {
      databaseHelper.insertVehicleCard(selectedVehicleCard.value!);
      isSaving(false);
      Get.off(() => ExtractedDataListView());
      getAllVehicleCards();
    } catch (e) {
      isSaving(false);
      print(e);
    }
  }

  Future<void> getAllVehicleCards() async {
    List<VehicleCard> vehicleCards = await databaseHelper.getAllVehicleCards();
    print(vehicleCards);
    extractedVehicleDataList.clear();
    extractedVehicleDataList.addAll(vehicleCards);
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.decelerate,
      );
    }
  }

  Future<void> exportToExcel(List<VehicleCard> vehicleList) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    // 📝 Ajout des en-têtes
    List<String> headers = [
      'Registration Plate',
      'Brand',
      'Model',
      'Color',
      'Owner',
      'Cylinder',
      'Gender',
      'Energy',
      'Seat Count',
      'Power',
      'Axles Count',
      'First Date',
      'Edition Date'
    ];

    for (int i = 0; i < headers.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
    }

    // 📌 Ajout des données
    for (int i = 0; i < vehicleList.length; i++) {
      final vehicle = vehicleList[i];
      sheet
          .getRangeByIndex(i + 2, 1)
          .setText(vehicle.registrationPlate ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 2).setText(vehicle.brand ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 3).setText(vehicle.model ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 4).setText(vehicle.color ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 5).setText(vehicle.owner ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 6).setText(vehicle.cylinder.toString());
      sheet.getRangeByIndex(i + 2, 7).setText(vehicle.gender ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 8).setText(vehicle.energy ?? 'N/A');
      sheet
          .getRangeByIndex(i + 2, 9)
          .setNumber(vehicle.seatingCapacity?.toDouble() ?? 0);
      sheet.getRangeByIndex(i + 2, 10).setText(vehicle.power.toString());
      sheet
          .getRangeByIndex(i + 2, 11)
          .setNumber(vehicle.axlesCount?.toDouble() ?? 0);
      sheet.getRangeByIndex(i + 2, 12).setText(vehicle.firstDate ?? 'N/A');
      sheet.getRangeByIndex(i + 2, 13).setText(vehicle.editionDate ?? 'N/A');
    }

    // 📂 Sauvegarde du fichier
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$path/ExtractedData.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    print('Fichier enregistré : ${file.path}');

    // 📂 Ouvre le fichier immédiatement
    OpenFilex.open(file.path);
  }

  Future<void> exportToPdf(List<VehicleCard> vehicleList) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 14); // Nombre de colonnes
    grid.headers.add(1); // Ligne d'en-tête

    // 📝 Ajout des en-têtes
    List<String> headers = [
      'id',
      'Registration Plate',
      'Brand',
      'Model',
      'Color',
      'Owner',
      'Cylinder',
      'Gender',
      'Energy',
      'Seat Count',
      'Power',
      'Axles Count',
      'First Date',
      'Edition Date'
    ];

    PdfGridRow headerRow = grid.headers[0];
    for (int i = 0; i < headers.length; i++) {
      headerRow.cells[i].value = headers[i];
    }

    // 📌 Ajout des données
    for (final vehicle in vehicleList) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = vehicleList.indexOf(vehicle).toString();
      row.cells[1].value = vehicle.registrationPlate ?? 'N/A';
      row.cells[2].value = vehicle.brand ?? 'N/A';
      row.cells[3].value = vehicle.model ?? 'N/A';
      row.cells[4].value = vehicle.color ?? 'N/A';
      row.cells[5].value = vehicle.owner ?? 'N/A';
      row.cells[6].value = vehicle.cylinder ?? 'N/A';
      row.cells[7].value = vehicle.gender ?? 'N/A';
      row.cells[8].value = vehicle.energy ?? 'N/A';
      row.cells[9].value = vehicle.seatingCapacity?.toString() ?? '0';
      row.cells[10].value = vehicle.power ?? 'N/A';
      row.cells[11].value = vehicle.axlesCount?.toString() ?? '0';
      row.cells[12].value = vehicle.firstDate ?? 'N/A';
      row.cells[13].value = vehicle.editionDate ?? 'N/A';
    }

    // 🎨 Appliquer un style (facultatif)
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
      cellPadding: PdfPaddings(left: 3, right: 3, top: 3, bottom: 3),
    );

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 0, 500, 800));

    // 📂 Sauvegarde du fichier
    final List<int> bytes = await document.save();
    document.dispose();

    final String path = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$path/ExtractedData.pdf');
    await file.writeAsBytes(bytes, flush: true);

    print('Fichier PDF enregistré : ${file.path}');
    // 📂 Ouvre le fichier immédiatement
    OpenFilex.open(file.path);
  }

  Future<void> exportToCsv(List<VehicleCard> vehicleList) async {
    final StringBuffer csvBuffer = StringBuffer();

    // 📝 Ajout des en-têtes
    csvBuffer.writeln(
        'Registration Plate,Brand,Model,Color,Owner,Cylinder,Gender,Energy,Seat Count,Power,Axles Count,First Date,Edition Date');

    // 📌 Ajout des données
    for (final vehicle in vehicleList) {
      csvBuffer.writeln([
        vehicle.registrationPlate ?? 'N/A',
        vehicle.brand ?? 'N/A',
        vehicle.model ?? 'N/A',
        vehicle.color ?? 'N/A',
        vehicle.owner ?? 'N/A',
        vehicle.cylinder ?? 'N/A',
        vehicle.gender ?? 'N/A',
        vehicle.energy ?? 'N/A',
        vehicle.seatingCapacity?.toString() ?? '0',
        vehicle.power ?? 'N/A',
        vehicle.axlesCount?.toString() ?? '0',
        vehicle.firstDate ?? 'N/A',
        vehicle.editionDate ?? 'N/A',
      ].join(','));
    }

    // 📂 Sauvegarde du fichier
    final String path = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$path/ExtractedData.csv');
    await file.writeAsString(csvBuffer.toString(), flush: true);

    print('Fichier CSV enregistré : ${file.path}');
    // 📂 Ouvre le fichier immédiatement
    OpenFilex.open(file.path);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onInit() async {
    scrollController = ScrollController();

    getAllVehicleCards();
    super.onInit();
  }
}
