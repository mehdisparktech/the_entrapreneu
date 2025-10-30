import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/helpers/other_helper.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(),

      /// Body Section starts here
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonImage(imageSrc: AppIcons.resetPassword, size: 250),
                  20.height,
                  const CommonText(
                    text: AppString.setNewPassword,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    bottom: 8,
                  ),
                  20.height,

                  /// New Password here
                  const CommonText(
                    text: AppString.newPassword,
                    bottom: 8,
                  ).start,
                  CommonTextField(
                    controller: controller.passwordController,

                    hintText: AppString.newPassword,
                    isPassword: true,
                    validator: OtherHelper.passwordValidator,
                  ),

                  /// Confirm Password here
                  const CommonText(
                    text: AppString.confirmPassword,
                    bottom: 8,
                    top: 12,
                  ).start,
                  CommonTextField(
                    controller: controller.confirmPasswordController,

                    hintText: AppString.confirmPassword,
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                      value,
                      controller.passwordController,
                    ),
                    isPassword: true,
                  ),
                  64.height,

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.continues,
                    isLoading: controller.isLoadingReset,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.resetPasswordRepo();
                      }
                    },
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
