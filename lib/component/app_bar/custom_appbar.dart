import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showMessage;
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColors;
  final double height;
  final TextStyle? textStyle;
  final VoidCallback? onBackTap; // 👈 Added custom back button handler

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.backgroundColor = Colors.transparent,
    this.titleColor = Colors.black,
    this.height = 60,
    this.textStyle,
    this.iconColors = Colors.black,
    this.showMessage = true,
    this.onBackTap, // 👈 optional custom action
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered title
          if (showMessage)
            Center(
              child: Text(
                title?.tr ?? '',
                style: textStyle ??
                    GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: AppColors.titleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
            ),

          // Back button
          if (showBackButton)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: onBackTap ?? () => Get.back(), // 👈 Default is Get.back()
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back_ios, color: iconColors, size: 24),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
