import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/component/text_field/common_text_field.dart';
import '../controller/change_password_controller.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_string.dart';
import 'package:the_entrapreneu/utils/helpers/other_helper.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonImage(imageSrc: AppIcons.changePassword, size: 200),
                  40.height,
                  const CommonText(
                    text: AppString.changePassword,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    bottom: 40,
                  ),

                  /// current Password section
                  const CommonText(
                    text: AppString.currentPassword,
                    bottom: 8,
                  ).start,
                  CommonTextField(
                    controller: controller.currentPasswordController,
                    hintText: AppString.currentPassword,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                  ),

                  /// New Password section
                  const CommonText(
                    text: AppString.newPassword,
                    bottom: 8,
                    top: 16,
                  ).start,
                  CommonTextField(
                    controller: controller.newPasswordController,
                    hintText: AppString.newPassword,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                  ),

                  /// confirm Password section
                  const CommonText(
                    text: AppString.confirmPassword,
                    bottom: 8,
                    top: 16,
                  ).start,
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    hintText: AppString.confirmPassword,
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                      value,
                      controller.newPasswordController,
                    ),
                    isPassword: true,
                  ),

                  20.height,

                  /// submit Button
                  CommonButton(
                    titleText: AppString.update,
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
