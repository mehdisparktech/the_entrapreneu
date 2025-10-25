import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class CustomTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.primaryColor,
              width: 1,
            ),
            gradient: isSelected
                ? LinearGradient(
                    colors: [AppColors.blueLight, AppColors.primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  )
                : null,
          ),
          child: Center(
            child: ShaderMask(
              shaderCallback: !isSelected
                  ? (bounds) => LinearGradient(
                      colors: [AppColors.blueLight, AppColors.primaryColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds)
                  : (bounds) => LinearGradient(
                      colors: [AppColors.white, AppColors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
              child: CommonText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
