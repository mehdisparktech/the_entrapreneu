import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class PostPublishingDialog {
  static void show(BuildContext context, {VoidCallback? onComplete}) {
    final RxInt progress = 0.obs;
    final RxString categoryText = 'Home & Property'.obs;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Start progress animation
        _startProgress(progress, categoryText, context, onComplete);

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: "Post Publishing",
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 24.h),

                // Circular Progress Indicator
                Obx(() => Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 180.w,
                      height: 180.h,
                      child: CircularProgressIndicator(
                        value: progress.value / 100,
                        strokeWidth: 12.w,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText(
                          text: "${progress.value}%",
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        CommonText(
                          text: "Complete",
                          fontSize: 24.sp,
                          color: AppColors.textColorFirst,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(height: 24.h),

                // Category Text
                Obx(() => CommonText(
                  text: categoryText.value,
                  fontSize: 14.sp,
                  color: Colors.grey,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _startProgress(
      RxInt progress,
      RxString categoryText,
      BuildContext context,
      VoidCallback? onComplete,
      ) {
    // Simulate progress over 2 seconds
    const totalDuration = 2000; // 2 seconds in milliseconds
    const updateInterval = 20; // Update every 20ms
    const steps = totalDuration ~/ updateInterval; // 100 steps
    int currentStep = 0;

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: updateInterval));
      currentStep++;
      progress.value = ((currentStep / steps) * 100).toInt();

      // Close dialog when complete
      if (currentStep >= steps) {
        Navigator.of(context).pop();
        if (onComplete != null) {
          onComplete();
        }
        return false; // Stop loop
      }
      return true; // Continue loop
    });
  }
}