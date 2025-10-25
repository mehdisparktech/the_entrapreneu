import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: const SizedBox(),
      centerTitle: true,
      title: const CommonText(
        text: 'Booking',
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
              title: 'Running',
              isSelected: controller.selectedTabIndex.value == 0,
              onTap: () => controller.changeTab(0),
            ),
            SizedBox(width: 8.w),
            CustomTabButton(
              title: 'Completed',
              isSelected: controller.selectedTabIndex.value == 1,
              onTap: () => controller.changeTab(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(HistoryController controller) {
    return Column(
      children: [
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
                  onTap: () => controller.navigateToDetails(request),
                );
              },
            );
          }),
        ),
      ],
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
