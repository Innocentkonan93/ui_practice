import 'dart:convert';
import 'dart:developer';

import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class GoogleService {
  final String _apiKey = 'AIzaSyC3iKKKZZwRo4Rpi5AUFkeUI06vNk7f_2Q'; //

  final clientId = ClientId(
      "950506261745-kjkspv9dnbj0hnd3t39ihpt2e5tflitc.apps.googleusercontent.com");
  final scopes = [SheetsApi.spreadsheetsScope];

  Future<void> writeToGoogleSheet(Map<String, dynamic> data) async {
    log(data.toString());
    var url = Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/1N4M15IqIkll16FdCv53v51HPz_1ZZRAOfytFEqfDUFA/values/Sheet1!A1:append?valueInputOption=RAW&key=$_apiKey');

    var response = await http.post(
      url,
      body: jsonEncode({
        "values": [
          [
            data['type'],
            data['country'],
            data['number'],
            data['last_name'],
            data['first_name'],
            data['date_of_birth'],
            data['gender'],
            data['height'],
            data['nationality'],
            data['place_of_birth'],
            data['expiration_date'],
            data['photo']['present'],
            data['signature']['present'],
            data['security_features'],
            data['remarks']
          ]
        ],
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('Data written successfully to Google Sheets!');
    } else {
      print('Failed to write data. Status code: ${response.statusCode}');
    }
  }

  Future<void> authenticateAndWriteToSheet() async {
    try {
      // Authentification OAuth2
      var client = await clientViaUserConsent(clientId, scopes, (url) {
        print("Please go to the following URL and grant access: ");
        print("  $url");

        // Attendre que l'utilisateur entre le code d'autorisation dans un navigateur
      });

      // Une fois l'authentification réussie, nous pouvons interagir avec l'API Google Sheets
      var sheetsApi = SheetsApi(client);

      // ID de la feuille de calcul Google Sheets
      var spreadsheetId = "1N4M15IqIkll16FdCv53v51HPz_1ZZRAOfytFEqfDUFA";
      var range =
          "Sheet1!A1"; // La plage à laquelle tu veux ajouter des données

      // Données à ajouter
      var valueRange = ValueRange.fromJson({
        "values": [
          ["Nouveau texte ici"] // Exemple de données
        ]
      });

      // Ajout des données dans Google Sheets
      var response = await sheetsApi.spreadsheets.values
          .append(valueRange, spreadsheetId, range, valueInputOption: "RAW");

      print("Données ajoutées avec succès !");
      print(response);
    } catch (e) {
      print("Erreur lors de l'authentification ou de l'ajout des données : $e");
    }
  }
}
