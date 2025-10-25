import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class ConfirmMessageDialog {
  static void show(BuildContext context,
      {required VoidCallback onCreateProfile}) {
    showDialog(
      context: context,
      barrierDismissible: false, // বাইরে চাপলে বন্ধ হবে না
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonText(
                text:
                "Are You A Service Provider? Please Complete Your Provider Profile To Start Offering Your Services And Reach More Customers!",
                fontSize: 14.sp,
                textAlign: TextAlign.center,
                color: Colors.black87,
                maxLines: 6,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: CommonText(
                        text: "Cancel",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CommonButton(
                      titleText: "Create Profile",
                      buttonRadius: 8,
                      buttonColor: AppColors.primaryColor,
                      onTap: () {
                        Navigator.pop(context);
                        onCreateProfile();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
