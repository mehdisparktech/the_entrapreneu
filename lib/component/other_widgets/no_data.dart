import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_string.dart';
import '../image/common_image.dart';
import '../text/common_text.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonImage(
            imageSrc: AppImages.noData,
            height: 70.sp,
            width: 70.sp,
          ),
          const CommonText(
            text: AppString.dataEmpty,
            fontSize: 16,
            top: 8,
          )
        ],
      ),
    );
  }
}
