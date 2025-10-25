import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.title, required this.iconDate});

  final String title;
  final IconData iconDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          /// show icon here
          Icon(iconDate, color: AppColors.secondary),

          /// show Title here
          CommonText(text: title, color: AppColors.secondary, left: 12),
          const Spacer(),

          /// show Icon here
          const Icon(Icons.arrow_forward_ios, color: AppColors.secondary),
        ],
      ),
    );
  }
}
