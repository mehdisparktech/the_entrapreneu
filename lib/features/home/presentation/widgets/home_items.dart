import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';

class HomeItem extends StatelessWidget {
  final VoidCallback? onTap;
  const HomeItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170.w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CommonImage(
                imageSrc: AppImages.detailsImage,
                height: 100.h,
                width: 145.w,
              ),
            ),
            SizedBox(height: 5.h,),
            CommonText(
              text: "\$100",
              fontSize: 20,
              color: AppColors.checkColor,
              fontWeight: FontWeight.w600,
            ),
            CommonText(
              text: "Experienced Plumber",
              fontSize: 12,
              color: AppColors.primaryWork,
              fontWeight: FontWeight.w600,
            ),
            CommonText(
              text: "California, Fresno ",
              fontSize: 12,
              color: AppColors.primaryWork,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}