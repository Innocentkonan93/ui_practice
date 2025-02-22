import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ui_challenge/app/modules/data_extractor/controllers/data_extractor_controller.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/vehicle_card.dart';

class ExtractedDataListView extends GetWidget<DataExtractorController> {
  const ExtractedDataListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Extracted Data List'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.download_for_offline_outlined),
            onSelected: (String value) async {
              if (value == 'Excel') {
                await controller
                    .exportToExcel(controller.extractedVehicleDataList);
              } else if (value == 'PDF') {
                await controller
                    .exportToPdf(controller.extractedVehicleDataList);
              } else if (value == 'CSV') {
                await controller
                    .exportToCsv(controller.extractedVehicleDataList);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                  value: 'Excel', child: Text('Exporter en Excel')),
              const PopupMenuItem(value: 'PDF', child: Text('Exporter en PDF')),
              const PopupMenuItem(value: 'CSV', child: Text('Exporter en CSV')),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.extractedVehicleDataList.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return SfDataGrid(
          source: VehicleDataSource(controller.extractedVehicleDataList),
          columnWidthMode: ColumnWidthMode
              .auto, // Ajuste automatiquement la largeur des colonnes
          columns: [
            GridColumn(
                columnName: 'registrationPlate',
                label: _buildHeader('Registration Plate')),
            GridColumn(columnName: 'brand', label: _buildHeader('Brand')),
            GridColumn(columnName: 'model', label: _buildHeader('Model')),
            GridColumn(columnName: 'color', label: _buildHeader('Color')),
            GridColumn(columnName: 'owner', label: _buildHeader('Owner')),
            GridColumn(columnName: 'cylinder', label: _buildHeader('Cylinder')),
            GridColumn(columnName: 'gender', label: _buildHeader('Gender')),
            GridColumn(columnName: 'energy', label: _buildHeader('Energy')),
            GridColumn(
                columnName: 'seatCount', label: _buildHeader('Seat Count')),
            GridColumn(columnName: 'power', label: _buildHeader('Power')),
            GridColumn(
                columnName: 'axlesCount', label: _buildHeader('Axles Count')),
            GridColumn(
                columnName: 'firstDate', label: _buildHeader('First Date')),
            GridColumn(
                columnName: 'editionDate', label: _buildHeader('Edition Date')),
          ],
        );
      }),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class VehicleDataSource extends DataGridSource {
  List<DataGridRow> _vehicleDataRows = [];

  VehicleDataSource(List<VehicleCard> vehicleList) {
    _vehicleDataRows = vehicleList.map<DataGridRow>((vehicle) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'registrationPlate',
            value: vehicle.registrationPlate ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'brand', value: vehicle.brand ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'model', value: vehicle.model ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'color', value: vehicle.color ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'owner', value: vehicle.owner ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'cylinder', value: vehicle.cylinder.toString()),
        DataGridCell<String>(
            columnName: 'gender', value: vehicle.gender ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'energy', value: vehicle.energy ?? 'N/A'),
        DataGridCell<int>(
            columnName: 'seatCount', value: vehicle.seatingCapacity ?? 0),
        DataGridCell<String>(
            columnName: 'power', value: vehicle.power.toString()),
        DataGridCell<int>(
            columnName: 'axlesCount', value: vehicle.axlesCount ?? 0),
        DataGridCell<String>(
            columnName: 'firstDate', value: vehicle.firstDate ?? 'N/A'),
        DataGridCell<String>(
            columnName: 'editionDate', value: vehicle.editionDate ?? 'N/A'),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _vehicleDataRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(cell.value.toString(), overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }
}
