import 'package:flutter/material.dart';

var promptVariable = """
  Analyse cette image qui est sans doute une carte et retourne uniquement les informations en français sous ce format  Map<String, String> sans ajouter d'autres textes,
  Retourne null pour les valeur introuvables ou illisibles
  Pour les cartes grise  les valeurs sont en après les titres:
  {
    "type": "XXXXXX",
    "owner": "XXXXXX",
    "number": "XXXX",
    "registrationPlate": "XXXX",
    "brand": "XXXXX",
    "model": "XXXX",
    "cylinder": "XXXX",
    "gender": "XXXXXXX",
    "color": "XXXXX",
    "body": "XXXXX",
    "energy": "XXXX",
    "seatingCapacity": "X",
    "usage": "XXX",
    "axlesCount": "XXXX",
    "power": "XXXXX",
    "grossWeight": "XXXXX",
    "emptyWeight": "XXXXX",
    "firstDate": "XXXX",
    "editionDate": "XXXX",
    "CU": "XXXXX",
    "remarks": "XXXXX"
  }
  et pour les autres carte :
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
  """;

// Exemple de motifs pour les chiffres 0 à 2
// Corrected patterns for 0-9 on a 5x3 grid display.
final Map<int, List<List<int>>> numberPatterns = {
  0: [
    [1, 1, 1],
    [1, 0, 1],
    [1, 0, 1],
    [1, 0, 1],
    [1, 1, 1],
  ],
  1: [
    [0, 1, 0],
    [1, 1, 0],
    [0, 1, 0],
    [0, 1, 0],
    [1, 1, 1],
  ],
  2: [
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 1],
    [1, 0, 0],
    [1, 1, 1],
  ],
  3: [
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 1],
  ],
  4: [
    [1, 0, 1],
    [1, 0, 1],
    [1, 1, 1],
    [0, 0, 1],
    [0, 0, 1],
  ],
  5: [
    [1, 1, 1],
    [1, 0, 0],
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 1],
  ],
  6: [
    [1, 1, 1],
    [1, 0, 0],
    [1, 1, 1],
    [1, 0, 1],
    [1, 1, 1],
  ],
  7: [
    [1, 1, 1],
    [0, 0, 1],
    [0, 1, 0],
    [0, 1, 0],
    [0, 1, 0],
  ],
  8: [
    [1, 1, 1],
    [1, 0, 1],
    [1, 1, 1],
    [1, 0, 1],
    [1, 1, 1],
  ],
  9: [
    [1, 1, 1],
    [1, 0, 1],
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 1],
  ],
};

final menu = [
  {
    "id": 0,
    "name": "Images",
    "icon": Icons.image,
  },
  {
    "id": 1,
    "name": "Camera",
    "icon": Icons.camera_alt,
  },
  {
    "id": 2,
    "name": "Contacts",
    "icon": Icons.contact_page_rounded,
  },
  {
    "id": 3,
    "name": "Files",
    "icon": Icons.file_present_outlined,
  },
];
final gallery = [
  {
    "id": 0,
    "image": "assets/images/1.png",
  },
  {
    "id": 1,
    "image": "assets/images/2.png",
  },
  {
    "id": 2,
    "image": "assets/images/3.png",
  },
  {
    "id": 3,
    "image": "assets/images/4.png",
  },
  {
    "id": 4,
    "image": "assets/images/1.png",
  },
  {
    "id": 5,
    "image": "assets/images/2.png",
  },
  {
    "id": 6,
    "image": "assets/images/3.png",
  },
  {
    "id": 7,
    "image": "assets/images/2.png",
  },
  {"id": 8, "image": "assets/images/4.png"},
  {"id": 9, "image": "assets/images/1.png"},
  {"id": 10, "image": "assets/images/2.png"},
  {"id": 11, "image": "assets/images/4.png"},
  {"id": 12, "image": "assets/images/1.png"},
  {"id": 13, "image": "assets/images/3.png"},
  {"id": 14, "image": "assets/images/2.png"},
  {"id": 15, "image": "assets/images/4.png"},
  {"id": 16, "image": "assets/images/1.png"},
  {"id": 17, "image": "assets/images/4.png"},
  {"id": 18, "image": "assets/images/3.png"},
  {"id": 19, "image": "assets/images/2.png"},
  {"id": 20, "image": "assets/images/4.png"},
  {"id": 21, "image": "assets/images/1.png"},
  {"id": 22, "image": "assets/images/3.png"},
  {"id": 23, "image": "assets/images/2.png"},
  {"id": 24, "image": "assets/images/4.png"},
];
