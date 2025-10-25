import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/utils/constants/app_images.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/history_controller.dart';
import '../controller/history_details_controller.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final bool showActions;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool isAcceptLoading;
  final bool isRejectLoading;
  final VoidCallback? onTap;

  const RequestCard({
    super.key,
    required this.request,
    this.showActions = false,
    this.onAccept,
    this.onReject,
    this.isAcceptLoading = false,
    this.isRejectLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _navigateToDetails(),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service info section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service icon
                Container(
                  width: 57.w,
                  height: 57.h,
                  decoration: BoxDecoration(
                    color: AppColors.blueLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CommonImage(
                    imageSrc: AppImages.noImage,
                    fill: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 10.w),

                // Service details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: request.title,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        text: request.subtitle,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 4.w),
                          CommonText(
                            text: request.date,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Price
                CommonText(
                  text: request.price,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ],
            ),

            if (showActions) ...[const Divider()],
            if (showActions) ...[SizedBox(height: 12.h)],
            if (showActions) ...[
              // Customer info section
              Row(
                children: [
                  // Customer avatar
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.grey3.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: ClipOval(
                      child: CommonImage(
                        imageSrc: request.customerImage,
                        width: 40.w,
                        height: 40.h,
                        fill: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Customer details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: request.customerName,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 2.h),
                        CommonText(
                          text: request.customerLocation,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            // Action buttons (only for pending requests)
            if (showActions) ...[
              SizedBox(height: 16.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        titleText: 'Reject',
                        titleColor: AppColors.cancel,
                        buttonColor: AppColors.white,
                        borderColor: AppColors.cancel,
                        buttonHeight: 34.h,
                        buttonWidth: 120.w,
                        titleSize: 14,
                        isLoading: isRejectLoading,
                        onTap: onReject,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: CommonButton(
                        titleText: 'Accept',
                        titleColor: AppColors.white,
                        buttonColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        buttonHeight: 40.h,
                        buttonWidth: 120.w,
                        titleSize: 14,
                        isLoading: isAcceptLoading,
                        onTap: onAccept,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigateToDetails() {
    // Set the selected request in the details controller
    final detailsController = Get.find<HistoryDetailsController>();
    detailsController.setSelectedRequest(request);
    // Navigate to details screen
    Get.toNamed('/history_details_screen.dart');
  }
}
