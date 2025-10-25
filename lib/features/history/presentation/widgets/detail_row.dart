import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;
  final bool isLast;

  const DetailRow({
    super.key,
    required this.label,
    this.value = '',
    this.valueWidget,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonText(
                text: label,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
                textAlign: TextAlign.left,
              ),
              valueWidget ??
                  Flexible(
                    child: CommonText(
                      text: value,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                      textAlign: TextAlign.right,
                      maxLines: 3,
                    ),
                  ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: AppColors.grey3.withOpacity(0.3),
            thickness: 1,
            height: 1,
          ),
      ],
    );
  }
}
