import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class SuccessReview {
  static void show(
    BuildContext context, {
    required String title,
    String? message,
    String buttonText = "OK",
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Success Icon
              CommonImage(
                imageSrc: "assets/images/success_image.png",
                height: 100.h,
                width: 100.w,
              ),
              SizedBox(height: 16.h),

              // ✅ Title
              CommonText(
                text: "Thank You For Your Valuables Feedback",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              CommonButton(
                titleText: "Done",
                buttonRadius: 10,
                buttonColor: AppColors.primaryColor,
                onTap: () {
                  Get.toNamed(AppRoutes.homeNav);
                  Get.snackbar(
                    title,
                    "Your review has been submitted successfully",
                    backgroundColor: AppColors.green,
                    colorText: AppColors.white,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
