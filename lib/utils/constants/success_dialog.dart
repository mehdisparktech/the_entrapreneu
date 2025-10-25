import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/image/common_image.dart';
import '../../component/text/common_text.dart';
import '../../features/home/presentation/widgets/custom_offer_dialog.dart';
import '../../utils/constants/app_colors.dart';

class SuccessDialog {
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
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
                text: "Your Custom Offer Submit Has been Successful. Please Wait for User Confirmations.",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              CommonButton(
                titleText: "Got it",
                buttonRadius: 10,
                buttonColor: AppColors.primaryColor,
                onTap: () {
                  Navigator.pop(context); // Close current dialog

                  // Show Custom Offer Request Dialog
                  CustomOfferRequestDialog.show(
                    context,
                    userName: "Savannah Nguyen",
                    userRole: "Electrician",
                    userImage: "https://via.placeholder.com/150",
                    rating: 4.5,
                    reviewCount: 150,
                    description: "We Are Looking For A Skilled And Reliable Plumber To Join Our Team. The Ideal Candidate Will Have Experience In Installing, Repairing, And Maintaining Residential And/Or Commercial Plumbing Systems.",
                    serviceDate: "01 January 2000",
                    serviceTime: "09:00 Am",
                    budget: "\$150",
                    onAccept: () {
                      // Handle accept
                      Get.snackbar(
                        'Success',
                        'Offer Accepted!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    onReject: () {
                      // Handle reject
                      Get.snackbar(
                        'Rejected',
                        'Offer Rejected!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    },
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
