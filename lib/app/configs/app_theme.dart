import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: const Color(0XFF2D308F),
    error: const Color.fromARGB(255, 191, 78, 69),
  ),

  scaffoldBackgroundColor: const Color.fromARGB(255, 239, 241, 244),
  dataTableTheme: DataTableThemeData(
      decoration: BoxDecoration(
    color: AppColors.white,
  )),
  cardTheme: CardTheme(
    color: AppColors.white, // reset margin
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
    surfaceTintColor: AppColors.white,
    backgroundColor: const Color.fromARGB(255, 250, 252, 255),
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
  ),

  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: Colors.white,
  //   contentPadding: const EdgeInsets.all(15),
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(
  //         width: .1, color: AppColors.green, style: BorderStyle.none),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(
  //         width: .1, color: AppColors.green, style: BorderStyle.none),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(
  //         width: .51, color: AppColors.green, style: BorderStyle.none),
  //   ),
  // ),
  splashColor: AppColors.lightPurple,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: AppColors.grey.withValues(alpha: .45),
        width: 0.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: AppColors.grey.withValues(alpha: .45),
        width: 0.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.red.withValues(alpha: .2),
        width: 0.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.purple,
        width: .8,
      ),
    ),
  ),
  radioTheme: const RadioThemeData(),
  textTheme: GoogleFonts.jostTextTheme()
      .copyWith(labelSmall: TextStyle(color: AppColors.grey)),
  fontFamily: "Poppins",
  useMaterial3: true,
);
