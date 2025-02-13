// ignore_for_file: avoid_print

import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String _apiKey =
      'AIzaSyA18oWbsufJsVLq840WWHJ-BcXMmQOjCoY'; // Remplacez par votre clé API Gemini

  List<Content> history = []; // Historique de la conversation

  // Méthode pour initialiser le contexte utilisateur

  Future<String?> getChatResponse(
    String text,
    List<Content> history,
  ) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: _apiKey,
      );

      // Ajoute le message de l'utilisateur à l'historique
      history.add(Content.text(text));

      final chat = model.startChat(history: history);
      final response = await chat.sendMessage(Content.text(text));

      // Extrait le texte de la réponse pour l'ajouter en tant que Content
      final responseText =
          response.text; // Assuming response has a `text` field
      history.add(Content.text(responseText!));

      // print(history);
      return responseText;
    } catch (e) {
      throw Exception(
          'Erreur lors de la récupération de la réponse du chat: $e');
    }
  }

  Future<GenerateContentResponse> analyzeImageWithPrompt(
      File imageFile, String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest', // Utilisation du modèle Vision
      apiKey: _apiKey,
    );

    // Convertit l'image en bytes
    final imageBytes = await imageFile.readAsBytes();

    // Envoie l'image et le texte en même temps
    final response = await model.generateContent([
      Content.multi([
        DataPart('image/jpeg', imageBytes), // Image
      ]),
      Content.text(prompt) // Ajout du texte
    ]);

    // Affiche la réponse
    print(response);
    return response;
  }
}
