import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import 'package:the_entrapreneu/utils/constants/app_string.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              140.height,
              const Center(child: CommonImage(imageSrc: AppIcons.onboarding)),
              60.height,
              CommonText(
                text: AppString.onboardingSubText,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                left: 40,
                right: 40,
                maxLines: 3,
              ),
              Spacer(),
              CommonButton(
                titleText: 'Get Started',
                buttonHeight: 50.h,
                buttonRadius: 10.r,
                titleSize: 18.sp,
                onTap: () {
                  Get.toNamed(AppRoutes.signUp);
                },
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
