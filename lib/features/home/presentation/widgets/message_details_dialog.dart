import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/text_field/common_text_field.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/create_post_controller.dart';

class MessageDetailsDialog {
  static void show(
      BuildContext context, {
        required VoidCallback onSend,
      }) {
    // Get the existing controller instance
    final controller = Get.find<CreatePostController>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Obx(
              () => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Message",
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                  color: Colors.black87,
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  maxLines: 4,
                  borderRadius: 8,
                  controller: controller.messageController,
                  fillColor: Colors.transparent,
                  borderColor: Colors.grey,
                  textColor: AppColors.textColorFirst,
                  hintText: "Type your message here...",
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
                        onPressed: controller.isSendingMessage.value
                            ? null
                            : () {
                          controller.messageController.clear();
                          Navigator.pop(context);
                        },
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
                        titleText: controller.isSendingMessage.value
                            ? "Sending..."
                            : "Send",
                        buttonRadius: 8,
                        buttonColor: Colors.green,
                        onTap: controller.isSendingMessage.value
                            ? () {}
                            : () async {
                          if (controller.messageController.text.trim().isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please enter a message',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }

                          Navigator.pop(context);
                          await controller.createChatRoom();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}