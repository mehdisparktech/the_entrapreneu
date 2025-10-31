import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../widget/already_accunt_rich_text.dart';
import '../widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();
    return Scaffold(
      /// App Bar Section Starts Here
      appBar: AppBar(),

      /// Body Section Starts Here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: signUpFormKey,
              child: Column(
                children: [
                  /// Sign UP Instructions here
                  const CommonText(
                    text: AppString.createYourAccount,
                    fontSize: 32,
                    bottom: 20,
                  ),

                  /// All Text Filed here
                  SignUpAllField(controller: controller),

                  16.height,

                  /// Submit Button Here
                  CommonButton(
                    titleText: AppString.signUp,
                    isLoading: controller.isLoading,
                    onTap: () => controller.signUpUser(signUpFormKey),
                  ),
                  SizedBox(height: 20),

                  CommonText(
                    text: "Or Sign Up With",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),

                  24.height,

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey, width: 2),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Apple Icon
                              SvgPicture.asset(
                                'assets/icons/googleicon.svg',
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),

                              // Apple Text
                              Text(
                                'Google',
                                style: TextStyle(
                                  color: AppColors.textColorFirst,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.h),
                      Expanded(
                        child: Container(
                          height: 48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey, width: 2),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Apple Icon
                              SvgPicture.asset(
                                'assets/icons/apple_fons.svg',
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),

                              // Apple Text
                              Text(
                                'Apple',
                                style: TextStyle(
                                  color: AppColors.textColorFirst,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),

                  ///  Sign In Instruction here
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 60.h,
          child: Column(children: [const AlreadyAccountRichText()]),
        ),
      ),
    );
  }
}
