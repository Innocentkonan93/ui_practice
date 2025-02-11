import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.isCircle = false,
    this.width,
    this.onTap,
  });

  final String title;
  final bool? isLoading;
  final double? width;
  final bool? isCircle;
  final VoidCallback? onTap;

  @override
  build(BuildContext context) {
    final theme = context.theme;

    return Visibility(
      visible: !isCircle!,
      replacement: SafeArea(
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 12000),
            width: isCircle! ? 50 : width,
            height: isCircle! ? 50 : null,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: onTap == null
                  ? const Color.fromARGB(255, 197, 197, 197)
                  : AppColors.purple,
              boxShadow: isLoading! == true
                  ? null
                  : [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        color: onTap == null || isLoading == true
                            ? AppColors.grey
                            : AppColors.purple.withValues(alpha: .7),
                        blurRadius: .5,
                      ),
                    ],
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppColors.purple,
                  Color.fromARGB(255, 104, 38, 192),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [.17, 1],
              ),
            ),
            padding: isCircle!
                ? const EdgeInsets.all(8)
                : const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "GO",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: isLoading == true ? null : onTap,
          child: Container(
            width: width,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: onTap == null || isLoading == true
                  ? const Color.fromARGB(255, 197, 197, 197)
                  : AppColors.purple,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isLoading! == true
                  ? null
                  : [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        color: onTap == null || isLoading == true
                            ? AppColors.grey
                            : AppColors.purple.withValues(alpha: .7),
                        blurRadius: .5,
                      ),
                    ],
              gradient: const LinearGradient(
                colors: [
                  AppColors.purple,
                  Color.fromARGB(255, 104, 38, 192),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [.17, 1],
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading! == true
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: AppColors.white),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
