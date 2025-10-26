import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/text_field/common_text_field.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class MessageDetailsDialog {
  static void show(BuildContext context,
      {required VoidCallback onSend}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text:
                "Message",
                fontSize: 14.sp,
                textAlign: TextAlign.center,
                color: Colors.black87,
              ),
              CommonTextField(
                maxLines: 4,
                borderRadius: 8,
                fillColor: Colors.transparent,
                borderColor: Colors.grey,
                textColor: AppColors.textColorFirst,
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
                      titleText: "Send",
                      buttonRadius: 8,
                      buttonColor: Colors.green,
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(AppRoutes.firstMessageScreen);
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
