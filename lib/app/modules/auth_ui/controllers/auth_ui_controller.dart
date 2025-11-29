import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/home_screen.dart';

class AuthUiController extends GetxController {
  final isLogin = true.obs;
  final isProcessing = false.obs;
  final isLoading = false.obs;
  final isInitial = true.obs;
  final currentFocus = "".obs; // Pour suivre le champ actuellement focalisé
  final validationErrors = <String>[].obs; // Liste des erreurs de validation

  final formKey = GlobalKey<FormState>();

  final nomController = Rxn<TextEditingController>();
  final emailController = Rxn<TextEditingController>();
  final passwordController = Rxn<TextEditingController>();
  final confirmationController = Rxn<TextEditingController>();

  // Focus nodes pour gérer le focus
  final nomFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmationFocusNode = FocusNode();

  // Messages dynamiques pour chaque champ
  String get dynamicMessage {
    if (isInitial.value) {
      return isLogin.value
          ? "Nous sommes heureux de vous revoir, connectez-vous pour accéder à votre espace"
          : "Veuillez créer un compte pour accéder à votre espace";
    }

    // Si il y a des erreurs de validation, les afficher
    if (validationErrors.isNotEmpty) {
      return validationErrors.join('\n');
    }

    switch (currentFocus.value) {
      case "nom":
        return "Entrez votre nom d'utilisateur unique pour votre compte";
      case "email":
        return isLogin.value
            ? "Entrer votre adresse e-mail qui a été utilisé pour créer votre compte"
            : "Entrez votre adresse e-mail, elle sera utilisée pour la connexion et la récupération de mot de passe";
      case "password":
        return isLogin.value
            ? "Votre mot de passe utilisé pour créer votre compte"
            : "Choisissez un mot de passe sécurisé avec au moins 8 caractères et une majuscule";
      case "confirmation":
        return "Confirmez votre mot de passe pour éviter les erreurs de saisie";
      default:
        return isLogin.value
            ? "Connectez-vous à votre compte"
            : "Créez votre nouveau compte";
    }
  }

  // Méthode pour ajouter une erreur à la liste
  void addValidationError(String error) {
    if (!validationErrors.contains(error)) {
      validationErrors.add(error);
      // update();
    }
  }

  // Méthode pour supprimer une erreur de la liste
  void removeValidationError(String error) {
    validationErrors.remove(error);
    update();
  }

  // Méthode pour vider toutes les erreurs
  void clearValidationErrors() {
    validationErrors.clear();
    update();
  }

  // Validation personnalisée pour chaque champ
  String? validateNom(String? value) {
    // Supprimer les anciennes erreurs liées au nom
    validationErrors.removeWhere((error) =>
        error.contains("nom d'utilisateur") ||
        error.contains("nom doit contenir"));

    if (value == null || value.isEmpty) {
      addValidationError("Le nom d'utilisateur est requis");
      return "Veuillez entrer un nom d'utilisateur";
    }
    if (value.length < 3) {
      addValidationError(
          "Le nom d'utilisateur doit contenir au moins 3 caractères");
      return "Le nom doit contenir au moins 3 caractères";
    }
    return null;
  }

  String? validateEmail(String? value) {
    // Supprimer les anciennes erreurs liées à l'email
    validationErrors.removeWhere((error) => error.contains("e-mail"));

    if (value == null || value.isEmpty) {
      addValidationError("L'adresse e-mail est requise");
      return "Veuillez entrer une adresse e-mail";
    }
    if (!GetUtils.isEmail(value)) {
      addValidationError("Veuillez entrer une adresse e-mail valide");
      return "Format d'e-mail invalide";
    }
    return null;
  }

  String? validatePassword(String? value) {
    // Supprimer les anciennes erreurs liées au mot de passe
    validationErrors.removeWhere((error) =>
        error.contains("mot de passe") && !error.contains("confirmation"));

    if (value == null || value.isEmpty) {
      addValidationError("Le mot de passe est requis");
      return "Veuillez entrer un mot de passe";
    }
    if (!isLogin.value && value.length < 8) {
      addValidationError("Le mot de passe doit contenir au moins 8 caractères");
      return "Le mot de passe non valide";
    }
    if (!isLogin.value && !value.contains(RegExp(r'[A-Z]'))) {
      addValidationError(
          "Le mot de passe doit contenir au moins une majuscule");
      return "Au moins une majuscule requise";
    }
    if (!isLogin.value && !value.contains(RegExp(r'[0-9]'))) {
      addValidationError("Le mot de passe doit contenir au moins un chiffre");
      return "Au moins un chiffre requis";
    }
    return null;
  }

  String? validateConfirmation(String? value) {
    // Supprimer les anciennes erreurs liées à la confirmation
    validationErrors.removeWhere((error) =>
        error.contains("confirmation") || error.contains("correspondent pas"));

    if (value == null || value.isEmpty) {
      addValidationError("La confirmation du mot de passe est requise");
      return "Veuillez confirmer votre mot de passe";
    }
    if (value != passwordController.value?.text) {
      addValidationError("Les mots de passe ne correspondent pas");
      return "Les mots de passe ne correspondent pas";
    }
    return null;
  }

  void toggle() {
    isLogin.value = !isLogin.value;
    formKey.currentState!.reset();
    validationErrors.value = [];
    currentFocus.value = "";
    update();
  }

  @override
  void onClose() {
    nomController.value?.dispose();
    emailController.value?.dispose();
    passwordController.value?.dispose();
    confirmationController.value?.dispose();

    // Dispose des focus nodes
    nomFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmationFocusNode.dispose();

    super.onClose();
  }

  void processing() async {
    // Réinitialiser les erreurs
    clearValidationErrors();

    if (!formKey.currentState!.validate()) {
      // Si la validation échoue, on ne continue pas
      return;
    }

    try {
      isProcessing.value = true;
      isLoading.value = true;
      update();
      await Future.delayed(const Duration(seconds: 3));
      stopProcessing();
      Get.offAll(
        () => const HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      stopProcessing();
    }
  }

  void stopProcessing() {
    isProcessing.value = false;
    isLoading.value = false;
    update();
  }

  double getAnimatedLeft(controller, double width) {
    if (controller.isLogin.value) return 0;
    if (controller.isProcessing.value) return 0;
    return width / 2;
  }

  double getAnimatedWidth(controller, double width) {
    return controller.isProcessing.value || isInitial.value ? width : width / 2;
  }

  Color getAnimatedColor(controller) {
    return controller.isLogin.value ? Colors.red : Colors.blue;
  }

  @override
  void onInit() async {
    // Initialiser les contrôleurs
    nomController.value = TextEditingController();
    emailController.value = TextEditingController();
    passwordController.value = TextEditingController();
    confirmationController.value = TextEditingController();

    // Ajouter les listeners pour le focus
    nomFocusNode.addListener(() {
      if (nomFocusNode.hasFocus) {
        currentFocus.value = "nom";
        update();
      }
    });

    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        currentFocus.value = "email";
        update();
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        currentFocus.value = "password";
        update();
      }
    });

    confirmationFocusNode.addListener(() {
      if (confirmationFocusNode.hasFocus) {
        currentFocus.value = "confirmation";
        update();
      }
    });

    await Future.delayed(Duration(seconds: 3));
    isInitial.value = false;
    update();
    super.onInit();
  }
}
