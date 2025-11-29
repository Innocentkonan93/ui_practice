import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_challenge/app/widgets/custom_button.dart';

import '../controllers/auth_ui_controller.dart';

class AuthUiView extends GetView<AuthUiController> {
  const AuthUiView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final theme = context.theme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        controller.currentFocus.value = "";
        controller.update();
      },
      child: Scaffold(
        body: GetBuilder<AuthUiController>(builder: (context) {
          return SizedBox(
            height: height,
            width: width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  height: height,
                  width: width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: height,
                          width: width / 2,
                          child: Visibility(
                            visible: !controller.isLogin.value,
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text(
                                    //   "Inscription",
                                    //   style:
                                    //       theme.textTheme.titleLarge?.copyWith(
                                    //     fontSize: 32,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    //   textAlign: TextAlign.center,
                                    // ),

                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        CupertinoIcons.person_add,
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    TextFormField(
                                      controller:
                                          controller.nomController.value,
                                      focusNode: controller.nomFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Nom d'utilisateur",
                                        prefixIcon: Icon(
                                          CupertinoIcons.person,
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: controller.validateNom,
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller:
                                          controller.emailController.value,
                                      focusNode: controller.emailFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Adresse e-mail",
                                        prefixIcon: Icon(
                                          CupertinoIcons.mail,
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: controller.validateEmail,
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller:
                                          controller.passwordController.value,
                                      focusNode: controller.passwordFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Mot de passe",
                                        prefixIcon: Icon(
                                          CupertinoIcons.lock,
                                        ),
                                      ),
                                      obscureText: true,
                                      obscuringCharacter: "*",
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: controller.validatePassword,
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: controller
                                          .confirmationController.value,
                                      focusNode:
                                          controller.confirmationFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Confirmer le mot de passe",
                                        prefixIcon: Icon(
                                          CupertinoIcons.lock_shield,
                                        ),
                                      ),
                                      obscureText: true,
                                      obscuringCharacter: "*",
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator:
                                          controller.validateConfirmation,
                                    ),
                                    const SizedBox(height: 32),
                                    CustomButton(
                                      title: "Inscription",
                                      onTap: () {
                                        controller.processing();
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      child: Text(
                                        "Vous avez déjà un compte ? Se connecter",
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: controller.toggle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: height,
                          width: width / 2,
                          child: Visibility(
                            visible: controller.isLogin.value,
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text(
                                    //   "Connexion",
                                    //   style:
                                    //       theme.textTheme.titleLarge?.copyWith(
                                    //     fontSize: 32,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    //   textAlign: TextAlign.center,
                                    // ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        CupertinoIcons.lock,
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    TextFormField(
                                      controller:
                                          controller.emailController.value,
                                      focusNode: controller.emailFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Adresse e-mail",
                                        prefixIcon: Icon(
                                          CupertinoIcons.mail,
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: controller.validateEmail,
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller:
                                          controller.passwordController.value,
                                      focusNode: controller.passwordFocusNode,
                                      decoration: InputDecoration(
                                        hintText: "Mot de passe",
                                        prefixIcon: Icon(
                                          CupertinoIcons.lock,
                                        ),
                                      ),
                                      obscureText: true,
                                      obscuringCharacter: "*",
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: controller.validatePassword,
                                    ),
                                    const SizedBox(height: 32),
                                    CustomButton(
                                      title: "Connexion",
                                      onTap: () {
                                        controller.processing();
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      child: Text(
                                        "Vous n'avez pas de compte ? S'inscrire",
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: controller.toggle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Effet "liquid glass" avec BackdropFilter et opacité
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  left: controller.getAnimatedLeft(controller, width),
                  curve: Curves.decelerate,
                  top: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: height,
                    width: controller.getAnimatedWidth(controller, width),
                    // On retire la couleur de fond ici pour laisser passer le flou
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          controller.isInitial.value ? 0 : 10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 38.0, sigmaY: 38.0),
                        child: AnimatedPadding(
                          padding: EdgeInsets.all(
                              controller.isInitial.value ? 0 : 20),
                          duration: Duration(milliseconds: 400),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1300),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: controller.isLogin.value
                                    ? Alignment.topLeft
                                    : Alignment.bottomRight,
                                end: controller.isLogin.value
                                    ? Alignment.bottomRight
                                    : Alignment.topLeft,
                                colors: controller.isLogin.value
                                    ? [
                                        const Color.fromARGB(
                                            180, 169, 135, 227),
                                        Colors.white.withOpacity(0.30),
                                      ]
                                    : [
                                        const Color.fromARGB(
                                            180, 169, 135, 227),
                                        Colors.white.withOpacity(0.30),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  controller.isInitial.value ? 0 : 10),
                              border: Border.all(
                                width: 1.2,
                                color: Colors.white.withOpacity(0.25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 24,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Visibility(
                                            visible: controller
                                                .validationErrors.isEmpty,
                                            replacement: Text(
                                              'Oops !',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 32.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            child: controller.isInitial.value
                                                ? AnimatedTextKit(
                                                    animatedTexts: [
                                                      TypewriterAnimatedText(
                                                        'Bienvenue !',
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 32.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        speed: const Duration(
                                                            milliseconds: 200),
                                                      ),
                                                    ],
                                                    totalRepeatCount: 1,
                                                    pause: const Duration(
                                                        milliseconds: 100),
                                                    displayFullTextOnTap: true,
                                                    stopPauseOnTap: true,
                                                  )
                                                : Text(
                                                    controller.isLogin.value
                                                        ? "Connectez-vous !"
                                                        : "Inscrivez-vous !",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 32.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 3,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 400),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              gradient: controller.currentFocus
                                                      .value.isNotEmpty
                                                  ? LinearGradient(
                                                      colors: [
                                                        Colors.white,
                                                        Colors.white
                                                            .withOpacity(0.01),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      stops: [0.2, 1.0],
                                                    )
                                                  : null,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ...controller.dynamicMessage
                                                    .split('\n')
                                                    .asMap()
                                                    .entries
                                                    .map(
                                                      (entry) => Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          if (controller
                                                              .validationErrors
                                                              .isNotEmpty)
                                                            Icon(
                                                              Icons
                                                                  .error_outline,
                                                              size: 15,
                                                              color: Colors.red,
                                                            ),
                                                          SizedBox(width: 5),
                                                          Flexible(
                                                            child:
                                                                AnimatedSwitcher(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                              transitionBuilder:
                                                                  (Widget child,
                                                                      Animation<
                                                                              double>
                                                                          animation) {
                                                                return FadeTransition(
                                                                    opacity:
                                                                        animation,
                                                                    child:
                                                                        child);
                                                              },
                                                              child: Text(
                                                                entry.value,
                                                                key: ValueKey(
                                                                    '${entry.key}_${entry.value}'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color: controller
                                                                          .validationErrors
                                                                          .isNotEmpty
                                                                      ? Colors
                                                                          .red
                                                                      : null,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Fonction utilitaire pour afficher le message animé

                // Fonctions utilitaires pour clarifier la logique
              ],
            ),
          );
        }),
      ),
    );
  }
}

Widget _buildAnimatedMessage(controller, ThemeData theme) {
  final String message = controller.isLogin.value
      ? "Nous sommes heureux de vous revoir, connectez-vous pour accéder à votre espace"
      : "Veuillez créer un compte pour accéder à votre espace";
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Visibility(
      visible: controller.isInitial.value,
      replacement: Center(
        child: Lottie.asset(
          "assets/animations/Welcome.json",
          height: 500,
        ),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge?.copyWith(),
      ).animate().fadeIn(duration: 1000.ms, delay: 3700.ms),
    ),
  );
}
