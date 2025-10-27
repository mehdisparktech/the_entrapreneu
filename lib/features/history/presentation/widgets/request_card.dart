import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/history_controller.dart';
import '../controller/history_details_controller.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final bool showActions;

  final VoidCallback? onTap;

  const RequestCard({
    super.key,
    required this.request,
    this.showActions = false,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service icon
            ClipOval(
              child: CommonImage(
                imageSrc: "assets/images/profile_image.png",
                fill: BoxFit.cover,
                size: 57,
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
                      ...List.generate(
                        5,
                        (index) =>
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      ),
                      CommonText(
                        text: '(150)',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText(
                  text: request.price,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 20.h),
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
          ],
        ),
      ),
    );
  }

  void _navigateToDetails() {
    // Initialize the details controller if not already initialized
    final detailsController = Get.put(HistoryDetailsController());
    // Set the selected request in the details controller
    detailsController.setSelectedRequest(request);
    // Navigate to details screen
    Get.toNamed(AppRoutes.historyDetailsScreen);
  }
}
