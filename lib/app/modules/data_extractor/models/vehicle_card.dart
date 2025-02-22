class VehicleCard {
  final String? type;
  final String? owner;
  final String? number;
  final String? registrationPlate;
  final String? brand;
  final String? model;
  final int? cylinder;
  final String? gender;
  final String? color;
  final String? body;
  final String? energy;
  final int? seatingCapacity;
  final String? usage;
  final int? axlesCount;
  final int? power;
  final int? grossWeight;
  final int? emptyWeight;
  final String? firstDate;
  final String? editionDate;
  final String? cu;
  final String? remarks;

  VehicleCard({
    this.type,
    this.owner,
    this.number,
    this.registrationPlate,
    this.brand,
    this.model,
    this.cylinder,
    this.gender,
    this.color,
    this.body,
    this.energy,
    this.seatingCapacity,
    this.usage,
    this.axlesCount,
    this.power,
    this.grossWeight,
    this.emptyWeight,
    this.firstDate,
    this.editionDate,
    this.cu,
    this.remarks,
  });

  factory VehicleCard.fromJson(Map<String, dynamic> json) {
    return VehicleCard(
      type: json['type'],
      owner: json['owner'],
      number: json['number'],
      registrationPlate: json['registrationPlate'],
      brand: json['brand'],
      model: json['model'],
      cylinder:
          json['cylinder'] != null ? int.tryParse(json['cylinder']) : null,
      gender: json['gender'],
      color: json['color'],
      body: json['body'],
      energy: json['energy'],
      seatingCapacity: json['seatingCapacity'] != null
          ? int.tryParse(json['seatingCapacity'])
          : null,
      usage: json['usage'],
      axlesCount:
          json['axlesCount'] != null ? int.tryParse(json['axlesCount']) : null,
      power: json['power'] != null ? int.tryParse(json['power']) : null,
      grossWeight: json['grossWeight'] != null
          ? int.tryParse(json['grossWeight'])
          : null,
      emptyWeight: json['emptyWeight'] != null
          ? int.tryParse(json['emptyWeight'])
          : null,
      firstDate: json['firstDate'],
      editionDate: json['editionDate'],
      cu: json['CU'],
      remarks: json['remarks'],
    );
  }

  factory VehicleCard.fromMap(Map<String, dynamic> json) {
    return VehicleCard(
      type: json['type'],
      owner: json['owner'],
      number: json['number'],
      registrationPlate: json['registrationPlate'],
      brand: json['brand'],
      model: json['model'],
      cylinder: json['cylinder'],
      gender: json['gender'],
      color: json['color'],
      body: json['body'],
      energy: json['energy'],
      seatingCapacity: json['seatingCapacity'],
      usage: json['usage'],
      axlesCount: json['axlesCount'],
      power: json['power'],
      grossWeight: json['grossWeight'],
      emptyWeight: json['emptyWeight'],
      firstDate: json['firstDate'],
      editionDate: json['editionDate'],
      cu: json['CU'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'owner': owner,
      'number': number,
      'registrationPlate': registrationPlate,
      'brand': brand,
      'model': model,
      'cylinder': cylinder?.toString(),
      'gender': gender,
      'color': color,
      'body': body,
      'energy': energy,
      'seatingCapacity': seatingCapacity?.toString(),
      'usage': usage,
      'axlesCount': axlesCount?.toString(),
      'power': power?.toString(),
      'grossWeight': grossWeight?.toString(),
      'emptyWeight': emptyWeight?.toString(),
      'firstDate': firstDate?.toString(),
      'editionDate': editionDate?.toString(),
      'CU': cu,
      'remarks': remarks,
    };
  }
}
