import 'package:flutter/material.dart';
import '../../../../../../config/route/app_routes.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../../component/pop_up/common_pop_menu.dart';
import '../../../../component/text/common_text.dart';
import '../controller/setting_controller.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widgets/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.settings,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      /// Body Section starts here
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                70.height,

                /// Change password Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                  child: const SettingItem(
                    title: AppString.changePassword,
                    iconDate: Icons.lock_outline,
                  ),
                ),

                /// Terms of Service Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                  child: const SettingItem(
                    title: AppString.termsOfServices,
                    iconDate: Icons.gavel,
                  ),
                ),

                /// Privacy Policy Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  child: const SettingItem(
                    title: AppString.privacyPolicy,
                    iconDate: Icons.network_wifi_1_bar,
                  ),
                ),

                /// Delete Account Item here
                InkWell(
                  onTap:
                      () => deletePopUp(
                        controller: controller.passwordController,
                        onTap: controller.deleteAccountRepo,
                        isLoading: controller.isLoading,
                      ),
                  child: Container(
                    height: 52.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.blueLight,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.secondary,
                        ),
                        CommonText(
                          text: AppString.deleteAccount,
                          color: AppColors.secondary,
                          left: 12.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}
