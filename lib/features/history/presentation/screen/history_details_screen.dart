import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
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

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Service Info Card
                _buildServiceInfoCard(request, controller),
                SizedBox(height: 20.h),

                // Details Card
                _buildDetailsCard(request, controller),

                SizedBox(height: 20.h),

                // Customer Info Card
                // _buildCustomerInfoCard(request),

                // Action Buttons (only for pending requests)
                if (controller.isPendingRequest)
                  _buildActionButtons(controller),
                SizedBox(height: 10.h),
                // Reject Reason Field (only for rejected requests)
                if (controller.isRejectedRequest)
                  _buildRejectReasonField(controller, context),
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: const CommonText(
        text: "View History",
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
          ClipOval(
            child: CommonImage(
              imageSrc: LocalStorage.myImage,
              fill: BoxFit.cover,
              size: 57,
            ),
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
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) =>
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    ),
                    CommonText(
                      text: '(2)',
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonText(
                text: request.price,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.checkColor,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryColor,
                    size: 14.sp,
                  ),
                  SizedBox(width: 8.w),
                  CommonText(
                    text: request.date,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Service Details",
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          SizedBox(height: 12.h),
          DetailRow(
            label: 'Service Status',
            valueWidget: StatusBadge(
              text: controller.serviceStatusText,
              type: _getStatusType(request.status),
            ),
          ),
          DetailRow(label: 'Time', value: '9:30 pm'),
          DetailRow(label: 'Priority Level', value: 'Normal'),
          DetailRow(label: 'Location', value: '2715 Ash Dr, San Jose, South'),
        ],
      ),
    );
  }

  Widget _buildActionButtons(HistoryDetailsController controller) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CommonButton(
              titleText: 'Message',
              titleColor: AppColors.black,
              buttonColor: AppColors.yellow.withOpacity(0.2),
              borderColor: AppColors.yellow.withOpacity(0.2),
              buttonHeight: 48.h,
              titleSize: 16,
              isLoading: controller.isRejectLoading.value,
              onTap: controller.rejectRequest,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: CommonButton(
              titleText: 'Complete',
              titleColor: AppColors.white,
              buttonColor: AppColors.green,
              borderColor: AppColors.green,
              buttonHeight: 48.h,
              titleSize: 16,
              isLoading: controller.isAcceptLoading.value,
              onTap: () {
                confirmDialog();
              },
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

  StatusType _getStatusType(dynamic status) {
    switch (status.toString()) {
      case 'RequestStatus.running':
        return StatusType.running;
      case 'RequestStatus.completed':
        return StatusType.completed;
      case 'RequestStatus.rejected':
        return StatusType.rejected;
      default:
        return StatusType.running;
    }
  }

  static void confirmDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to Complete This Order?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Added spacing
            children: [
              Expanded(
                // Added to prevent overflow
                child: CommonButton(
                  titleText: "No",
                  buttonColor: AppColors.grey,
                  titleColor: Colors.black,
                  onTap: () => Get.back(),
                ),
              ),
              const SizedBox(width: 8), // Added spacing between buttons
              Expanded(
                // Added to prevent overflow
                child: CommonButton(
                  titleText: "Yes",
                  buttonColor: AppColors.red,
                  titleColor: Colors.white,
                  onTap: () {
                    Get.toNamed(AppRoutes.reviewScreen);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
