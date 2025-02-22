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
