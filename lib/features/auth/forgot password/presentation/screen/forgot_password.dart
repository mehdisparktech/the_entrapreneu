import 'package:flutter/material.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/helpers/other_helper.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        /// App Bar Section
        appBar: AppBar(),

        /// body section
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonImage(imageSrc: AppIcons.forgotPassword, size: 250),
                20.height,
                const CommonText(
                  text: AppString.forgotPassword,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  bottom: 8,
                ),
                const CommonText(
                  text: AppString.forgotPasswordsubtitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  color: AppColors.secondaryText,
                ),

                /// forget password take email for reset Password
                const CommonText(
                  text: AppString.email,
                  bottom: 8,
                  top: 60,
                ).start,
                CommonTextField(
                  controller: controller.emailController,
                  hintText: AppString.email,
                  validator: OtherHelper.emailValidator,
                ),
                50.height,
              ],
            ),
          ),
        ),

        /// Bottom Navigation Bar Section
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),

          /// Submit Button
          child: CommonButton(
            titleText: AppString.continues,
            isLoading: controller.isLoadingEmail,
            onTap: () {
              if (formKey.currentState!.validate()) {
                controller.forgotPasswordRepo();
              }
            },
          ),
        ),
      ),
    );
  }
}
