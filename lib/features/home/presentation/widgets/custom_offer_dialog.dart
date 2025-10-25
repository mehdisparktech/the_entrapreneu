import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class CustomOfferRequestDialog {
  static void show(
      BuildContext context, {
        required String userName,
        required String userRole,
        required String userImage,
        required double rating,
        required int reviewCount,
        required String description,
        required String serviceDate,
        required String serviceTime,
        required String budget,
        VoidCallback? onAccept,
        VoidCallback? onReject,
      }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: CommonText(
                      text: "Custom Offer Request",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // User Info Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        // User Avatar
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: NetworkImage(userImage),
                          backgroundColor: Colors.grey[300],
                        ),
                        SizedBox(width: 12.w),

                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: userName,
                                fontSize: 14.sp,
                                color: AppColors.textColorFirst,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 4.h),
                              CommonText(
                                text: userRole,
                                fontSize: 12.sp,
                                color: AppColors.textColorFirst,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index < rating.floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.orange,
                                      size: 14.sp,
                                    );
                                  }),
                                  SizedBox(width: 6.w),
                                  CommonText(
                                    text: "(150)",
                                    fontSize: 12.sp,
                                    color: AppColors.textColorFirst,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Description Section
                  CommonText(
                    text: "Description",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColorFirst,
                  ),
                  SizedBox(height: 8.h),
                  CommonText(
                    text: description,
                    fontSize: 12.sp,
                    color: AppColors.textColorFirst,
                    maxLines: 10,
                  ),
                  SizedBox(height: 20.h),

                  // Service Date Section
                  CommonText(
                    text: "Service Date",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColorFirst,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CommonText(
                      text: serviceDate,
                      fontSize: 16.sp,
                      color: AppColors.textColorFirst,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Service Time Section
                  CommonText(
                    text: "Service Time",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColorFirst,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CommonText(
                      text: serviceTime,
                      fontSize: 16.sp,
                      color: AppColors.textColorFirst,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Budget Section
                  CommonText(
                    text: "Budget",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColorFirst,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CommonText(
                      text: budget,
                      fontSize: 16.sp,
                      color: AppColors.textColorFirst,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          titleText: "Reject Offer",
                          buttonColor: Colors.orange,
                          buttonRadius: 8,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CommonButton(
                          titleText: "Accept Offer",
                          buttonColor: AppColors.primaryColor,
                          buttonRadius: 8,
                          onTap: () {
                            Navigator.pop(context);
                            showCustomDialog(context, title: "Start Payment System.Fully Backend Development Process.");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  static void showCustomDialog(BuildContext context, {required String title, String? message, String buttonText = "OK"}) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: CommonText(
              text: title,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              color: AppColors.textColorFirst,
            maxLines: 3,
          ),
          content: message != null ? Text(message, style: TextStyle(fontSize: 14)) : null,
          actions: [
            CommonButton(
                titleText: "Done",
                buttonRadius: 8,
                buttonColor: AppColors.primaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
            )
          ],
        );
      },
    );
  }

}