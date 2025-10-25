import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/change_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../utils/helpers/other_helper.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.changePassword,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonImage(imageSrc: AppIcons.changePassword, size: 250),
                  20.height,
                  const CommonText(
                    text: AppString.changePassword,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    bottom: 8,
                  ),
                  const CommonText(
                    text: AppString.changePasswordsubtitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    color: AppColors.secondaryText,
                  ),

                  /// current Password section
                  const CommonText(text: AppString.currentPassword, bottom: 8),
                  CommonTextField(
                    controller: controller.currentPasswordController,
                    hintText: AppString.currentPassword,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock, size: 20.sp),
                  ),

                  /// New Password section
                  const CommonText(
                    text: AppString.newPassword,
                    bottom: 8,
                    top: 16,
                  ),
                  CommonTextField(
                    controller: controller.newPasswordController,
                    hintText: AppString.newPassword,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock, size: 20.sp),
                  ),

                  /// confirm Password section
                  const CommonText(
                    text: AppString.confirmPassword,
                    bottom: 8,
                    top: 16,
                  ),
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    hintText: AppString.confirmPassword,
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                      value,
                      controller.newPasswordController,
                    ),
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock, size: 20.sp),
                  ),

                  /// forget Password button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: CommonText(
                        text: AppString.forgotPassword,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        top: 16.h,
                        bottom: 20.h,
                      ),
                    ),
                  ),

                  /// submit Button
                  CommonButton(
                    titleText: AppString.confirm,
                    isLoading: controller.isLoading,
                    onTap: controller.changePasswordRepo,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
