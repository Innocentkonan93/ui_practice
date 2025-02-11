import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class IdentityCard {
  final String? type;
  final String? drivingLicenseCategory;
  final String? country;
  final String? number;
  final String? lastName;
  final String? firstName;
  final String? dateOfBirth;
  final String? gender;
  final String? height;
  final String? nationality;
  final String? placeOfBirth;
  final String? expirationDate;
  final Photo? photo;
  final Signature? signature;
  final List<String>? securityFeatures;
  final String? remarks;

  IdentityCard({
    this.type,
    this.drivingLicenseCategory,
    this.country,
    this.number,
    this.lastName,
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.height,
    this.nationality,
    this.placeOfBirth,
    this.expirationDate,
    this.photo,
    this.signature,
    this.securityFeatures,
    this.remarks,
  });

  factory IdentityCard.fromJson(Map<String, dynamic> json) {
    return IdentityCard(
      type: json['type'],
      drivingLicenseCategory: json['driving_license_category'],
      country: json['country'],
      number: json['number'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      height: json['height'],
      nationality: json['nationality'],
      placeOfBirth: json['place_of_birth'],
      expirationDate: json['expiration_date'],
      photo: Photo.fromJson(json['photo']),
      signature: Signature.fromJson(json['signature']),
      securityFeatures: List<String>.from(json['security_features']),
      remarks: json['remarks'],
    );
  }

  IdentityCard copyWith({
    ValueGetter<String?>? type,
    ValueGetter<String?>? drivingLicenseCategory,
    ValueGetter<String?>? country,
    ValueGetter<String?>? number,
    ValueGetter<String?>? lastName,
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? dateOfBirth,
    ValueGetter<String?>? gender,
    ValueGetter<String?>? height,
    ValueGetter<String?>? nationality,
    ValueGetter<String?>? placeOfBirth,
    ValueGetter<String?>? expirationDate,
    ValueGetter<Photo?>? photo,
    ValueGetter<Signature?>? signature,
    ValueGetter<List<String>?>? securityFeatures,
    ValueGetter<String?>? remarks,
  }) {
    return IdentityCard(
      type: type != null ? type() : this.type,
      drivingLicenseCategory: drivingLicenseCategory != null
          ? drivingLicenseCategory()
          : this.drivingLicenseCategory,
      country: country != null ? country() : this.country,
      number: number != null ? number() : this.number,
      lastName: lastName != null ? lastName() : this.lastName,
      firstName: firstName != null ? firstName() : this.firstName,
      dateOfBirth: dateOfBirth != null ? dateOfBirth() : this.dateOfBirth,
      gender: gender != null ? gender() : this.gender,
      height: height != null ? height() : this.height,
      nationality: nationality != null ? nationality() : this.nationality,
      placeOfBirth: placeOfBirth != null ? placeOfBirth() : this.placeOfBirth,
      expirationDate:
          expirationDate != null ? expirationDate() : this.expirationDate,
      photo: photo != null ? photo() : this.photo,
      signature: signature != null ? signature() : this.signature,
      securityFeatures:
          securityFeatures != null ? securityFeatures() : this.securityFeatures,
      remarks: remarks != null ? remarks() : this.remarks,
    );
  }

  factory IdentityCard.fromMap(Map<String, dynamic> map) {
    return IdentityCard(
      type: map['type'],
      drivingLicenseCategory: map['drivingLicenseCategory'],
      country: map['country'],
      number: map['number'],
      lastName: map['lastName'],
      firstName: map['firstName'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      height: map['height'],
      nationality: map['nationality'],
      placeOfBirth: map['placeOfBirth'],
      expirationDate: map['expirationDate'],
      photo: map['photo'] != null ? Photo.fromMap(map['photo']) : null,
      signature:
          map['signature'] != null ? Signature.fromMap(map['signature']) : null,
      securityFeatures: List<String>.from(map['securityFeatures']),
      remarks: map['remarks'],
    );
  }

  @override
  String toString() {
    return 'IdentityCard(type: $type, drivingLicenseCategory:$drivingLicenseCategory, country: $country, number: $number, lastName: $lastName, firstName: $firstName, dateOfBirth: $dateOfBirth, gender: $gender, height: $height, nationality: $nationality, placeOfBirth: $placeOfBirth, expirationDate: $expirationDate, photo: $photo, signature: $signature, securityFeatures: $securityFeatures, remarks: $remarks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IdentityCard &&
        other.type == type &&
        other.drivingLicenseCategory == drivingLicenseCategory &&
        other.country == country &&
        other.number == number &&
        other.lastName == lastName &&
        other.firstName == firstName &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.height == height &&
        other.nationality == nationality &&
        other.placeOfBirth == placeOfBirth &&
        other.expirationDate == expirationDate &&
        other.photo == photo &&
        other.signature == signature &&
        listEquals(other.securityFeatures, securityFeatures) &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        drivingLicenseCategory.hashCode ^
        country.hashCode ^
        number.hashCode ^
        lastName.hashCode ^
        firstName.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        nationality.hashCode ^
        placeOfBirth.hashCode ^
        expirationDate.hashCode ^
        photo.hashCode ^
        signature.hashCode ^
        securityFeatures.hashCode ^
        remarks.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'drivingLicenseCategory': drivingLicenseCategory,
      'country': country,
      'number': number,
      'lastName': lastName,
      'firstName': firstName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'height': height,
      'nationality': nationality,
      'placeOfBirth': placeOfBirth,
      'expirationDate': expirationDate,
      'photo': photo?.toMap(),
      'signature': signature?.toMap(),
      'securityFeatures': securityFeatures,
      'remarks': remarks,
    };
  }

  String toJson() => json.encode(toMap());
}

class Photo {
  final bool present;
  final String description;

  Photo({
    required this.present,
    required this.description,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      present: json['present'],
      description: json['description'],
    );
  }

  Photo copyWith({
    bool? present,
    String? description,
  }) {
    return Photo(
      present: present ?? this.present,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'present': present,
      'description': description,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      present: map['present'] ?? false,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Photo(present: $present, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Photo &&
        other.present == present &&
        other.description == description;
  }

  @override
  int get hashCode => present.hashCode ^ description.hashCode;
}

class Signature {
  final bool present;
  final String? description;

  Signature({
    required this.present,
    this.description,
  });

  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(
      present: json['present'],
      description: json['description'],
    );
  }

  Signature copyWith({
    bool? present,
    ValueGetter<String?>? description,
  }) {
    return Signature(
      present: present ?? this.present,
      description: description != null ? description() : this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'present': present,
      'description': description,
    };
  }

  factory Signature.fromMap(Map<String, dynamic> map) {
    return Signature(
      present: map['present'] ?? false,
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Signature(present: $present, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Signature &&
        other.present == present &&
        other.description == description;
  }

  @override
  int get hashCode => present.hashCode ^ description.hashCode;
}
