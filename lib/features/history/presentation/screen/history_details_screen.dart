import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_images.dart';
import 'package:the_entrapreneu/utils/enum/enum.dart';
import '../controller/history_details_controller.dart';
import '../widgets/detail_row.dart';
import '../widgets/status_badge.dart';

class HistoryDetailsScreen extends StatelessWidget {
  const HistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryDetailsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Obx(() {
        final request = controller.selectedRequest.value;
        if (request == null) {
          return const Center(
            child: CommonText(
              text: 'No data available',
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Service Info Card
              _buildServiceInfoCard(request, controller),
              SizedBox(height: 20.h),

              if (controller.isUpcomingRequest)
                CommonButton(
                  titleText: "Cancel Order",
                  buttonColor: AppColors.transparent,
                  titleColor: AppColors.cancel,
                  titleWeight: FontWeight.w400,
                  borderColor: AppColors.cancel,
                  buttonRadius: 30,
                  buttonHeight: 40,
                ),

              SizedBox(height: 20.h),

              // Details Card
              _buildDetailsCard(request, controller),

              SizedBox(height: 20.h),

              // Customer Info Card
              // _buildCustomerInfoCard(request),

              // Action Buttons (only for pending requests)
              if (controller.isPendingRequest) _buildActionButtons(controller),
              SizedBox(height: 10.h),
              // Reject Reason Field (only for rejected requests)
              if (controller.isRejectedRequest)
                _buildRejectReasonField(controller, context),
              if (controller.isUpcomingRequest) _buildPendingButton(controller),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      title: const CommonText(
        text: "Order Details",
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildServiceInfoCard(
    dynamic request,
    HistoryDetailsController controller,
  ) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          // Service Icon
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.blueLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CommonImage(imageSrc: AppImages.noImage, fill: BoxFit.cover),
          ),

          SizedBox(width: 16.w),

          // Service Details
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
                CommonText(
                  text: request.date,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  textAlign: TextAlign.left,
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
    );
  }

  Widget _buildDetailsCard(
    dynamic request,
    HistoryDetailsController controller,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
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
        children: [
          DetailRow(
            label: 'Service Status',
            valueWidget: StatusBadge(
              text: controller.serviceStatusText,
              type: _getStatusType(request.status),
            ),
          ),
          DetailRow(
            label: 'Payment Status',
            valueWidget: StatusBadge(
              text: controller.paymentStatusText,
              type: StatusType.complete,
            ),
          ),
          DetailRow(label: 'Distance', value: '5 km'),
          DetailRow(label: 'Location', value: '2715 Ash Dr, San Jose, South'),
          DetailRow(
            label: 'Special Note',
            value: 'Punctuality Matters. Kindly Be On Time For Your Service.',
            isLast: true,
          ),
          Divider(),
          _buildCustomerInfoCard(request),
        ],
      ),
    );
  }

  Widget _buildCustomerInfoCard(dynamic request) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.profile),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Color(0xffFEEEEE),
          borderRadius: BorderRadius.circular(12.r),
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
          children: [
            // Customer Avatar
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: CommonImage(
                  imageSrc: request.customerImage,
                  width: 50.w,
                  height: 50.h,
                  fill: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Customer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: request.customerName,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 4.h),
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
      ),
    );
  }

  Widget _buildActionButtons(HistoryDetailsController controller) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CommonButton(
              titleText: 'Reject',
              titleColor: AppColors.cancel,
              buttonColor: AppColors.white,
              borderColor: AppColors.cancel,
              buttonHeight: 36.h,
              titleSize: 16,
              isLoading: controller.isRejectLoading.value,
              onTap: controller.rejectRequest,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: CommonButton(
              titleText: 'Accept',
              titleColor: AppColors.white,
              buttonColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
              buttonHeight: 36.h,
              titleSize: 16,
              isLoading: controller.isAcceptLoading.value,
              onTap: controller.acceptRequest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectReasonField(
    HistoryDetailsController controller,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: 'Reject Reason',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.cancel,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10.h),
            CommonText(
              text:
                  'Sorry, I am unable to accept this order due to a scheduling conflict. Please reschedule or choose another available provider.',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
              textAlign: TextAlign.left,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingButton(HistoryDetailsController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Expanded(
            child: CommonButton(
              titleText: 'Message',
              titleColor: AppColors.black,
              buttonColor: AppColors.yellow.withOpacity(0.2),
              borderColor: AppColors.yellow.withOpacity(0.2),
              buttonHeight: 36.h,
              titleSize: 14,
              isLoading: false,
              titleWeight: FontWeight.normal,
              onTap: () {},
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: CommonButton(
              titleText: 'Call',
              titleColor: AppColors.black,
              buttonColor: AppColors.green.withOpacity(0.2),
              borderColor: AppColors.green.withOpacity(0.2),
              buttonHeight: 36.h,
              titleSize: 14,
              titleWeight: FontWeight.normal,
              isLoading: false,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  StatusType _getStatusType(dynamic status) {
    switch (status.toString()) {
      case 'RequestStatus.pending':
        return StatusType.pending;
      case 'RequestStatus.upcoming':
        return StatusType.upcoming;
      case 'RequestStatus.completed':
        return StatusType.complete;
      case 'RequestStatus.rejected':
        return StatusType.rejected;
      default:
        return StatusType.pending;
    }
  }
}
