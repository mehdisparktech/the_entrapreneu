import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../../utils/constants/app_string.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();

  /// init State here
  @override
  void initState() {
    ForgetPasswordController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section
      appBar: AppBar(),

      /// Body Section
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CommonImage(imageSrc: AppIcons.forgotPassword, size: 250),
                  20.height,
                  const CommonText(
                    text: AppString.otpVerify,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    bottom: 8,
                  ),

                  /// instruction how to get OTP
                  Center(
                    child: CommonText(
                      text:
                          "${AppString.codeHasBeenSendTo} ${controller.emailController.text}",
                      fontSize: 16,

                      bottom: 60,
                      maxLines: 2,
                      color: AppColors.secondaryText,
                    ),
                  ),

                  /// OTP Filed here
                  Flexible(
                    flex: 0,
                    child: PinCodeTextField(
                      controller: controller.otpController,
                      validator: (value) {
                        if (value != null && value.length == 6) {
                          return null;
                        } else {
                          return AppString.otpIsInValid;
                        }
                      },
                      autoDisposeControllers: false,
                      cursorColor: AppColors.black,
                      appContext: (context),
                      autoFocus: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 60.h,
                        fieldWidth: 60.w,
                        activeFillColor: AppColors.transparent,
                        selectedFillColor: AppColors.transparent,
                        inactiveFillColor: AppColors.transparent,
                        borderWidth: 0.5.w,
                        selectedColor: AppColors.primaryColor,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.black,
                      ),
                      length: 6,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.disabled,
                      enableActiveFill: true,
                    ),
                  ),

                  /*GestureDetector(
                    onTap: controller.time == '00:00'
                        ? () {
                            controller.startTimer();
                            controller.forgotPasswordRepo();
                          }
                        : () {},
                    child: CommonText(
                      text: controller.time == '00:00'
                          ? AppString.resendCode
                          : "${AppString.resendCodeIn} ${controller.time} ${AppString.minute}",
                      top: 10,
                      bottom: 20,
                      fontSize: 16,
                    ),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonText(
                        text: "Didn't receive the code?",
                        fontSize: 16,
                        bottom: 40,
                        maxLines: 3,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                      CommonText(
                        text: "Resend",
                        fontSize: 16,
                        bottom: 40,
                        fontWeight: FontWeight.w700,
                        maxLines: 3,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),

                  ///  Submit Button here
                  CommonButton(
                    titleText: AppString.verify,
                    isLoading: controller.isLoadingVerify,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.verifyOtpRepo();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
