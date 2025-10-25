import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/bottom_nav_bar/common_bottom_bar.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import '../controller/history_controller.dart';
import '../widgets/custom_tab_button.dart';
import '../widgets/request_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Tab buttons
            _buildTabButtons(controller),

            SizedBox(height: 20.h),

            // Content based on selected tab
            Expanded(child: _buildTabContent(controller)),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavBar(currentIndex: 2),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: const SizedBox(),
      centerTitle: true,
      title: const CommonText(
        text: 'History',
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTabButtons(HistoryController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.transparent,
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
      child: Obx(
        () => Row(
          children: [
            CustomTabButton(
              title: 'Pending',
              isSelected: controller.selectedTabIndex.value == 0,
              onTap: () => controller.changeTab(0),
            ),
            SizedBox(width: 8.w),
            CustomTabButton(
              title: 'Upcoming',
              isSelected: controller.selectedTabIndex.value == 1,
              onTap: () => controller.changeTab(1),
            ),
            SizedBox(width: 8.w),
            CustomTabButton(
              title: 'History',
              isSelected: controller.selectedTabIndex.value == 2,
              onTap: () => controller.changeTab(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(HistoryController controller) {
    return Column(
      children: [
        // Show filter buttons only for History tab
        Obx(
          () => controller.selectedTabIndex.value == 2
              ? _buildHistoryFilterButtons(controller)
              : const SizedBox(),
        ),

        // Content area
        Expanded(
          child: Obx(() {
            final currentData = controller.currentTabData;

            if (currentData.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              itemCount: currentData.length,
              itemBuilder: (context, index) {
                final request = currentData[index];
                final isPendingTab = controller.selectedTabIndex.value == 0;

                return RequestCard(
                  request: request,
                  showActions: isPendingTab,
                  onAccept: isPendingTab
                      ? () => controller.acceptRequest(request.id)
                      : null,
                  onReject: isPendingTab
                      ? () => controller.rejectRequest(request.id)
                      : null,
                  isAcceptLoading: controller.isAcceptLoading.value,
                  isRejectLoading: controller.isRejectLoading.value,
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildHistoryFilterButtons(HistoryController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CommonButton(
                titleText: 'Completed',
                onTap: () => controller.changeHistoryFilter(0),
                buttonColor: controller.selectedHistoryFilter.value == 0
                    ? AppColors.green
                    : AppColors.white,
                titleColor: controller.selectedHistoryFilter.value == 0
                    ? AppColors.white
                    : AppColors.green,
                borderColor: AppColors.green,
                borderWidth: 1,
                buttonHeight: 40.h,
                titleSize: 14,
                titleWeight: FontWeight.w500,
                buttonRadius: 60,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Obx(
              () => CommonButton(
                titleText: 'Rejected',
                onTap: () => controller.changeHistoryFilter(1),
                buttonColor: controller.selectedHistoryFilter.value == 1
                    ? AppColors.red
                    : AppColors.white,
                titleColor: controller.selectedHistoryFilter.value == 1
                    ? AppColors.white
                    : AppColors.red,
                borderColor: AppColors.red,
                borderWidth: 1,
                buttonHeight: 40.h,
                titleSize: 14,
                titleWeight: FontWeight.w500,
                buttonRadius: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64.sp, color: AppColors.grey3),
          SizedBox(height: 16.h),
          CommonText(
            text: 'No requests found',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.grey3,
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: 'Your requests will appear here',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ],
      ),
    );
  }
}
