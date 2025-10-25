import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/app_colors.dart';
import '../image/common_image.dart';
import '../text/common_text.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    this.icon,
    required this.title,
    this.imageSrc = "",
    this.disableDivider = false,
    this.onTap,
    this.color = AppColors.black,
    this.vertical = 8,
    this.horizontal = 4,
    this.disableIcon = false,
  });

  final IconData? icon;
  final String title;
  final String imageSrc;
  final bool disableDivider;
  final bool disableIcon;
  final VoidCallback? onTap;
  final Color color;
  final double vertical;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(
        horizontal: horizontal.w,
        vertical: vertical.h,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                icon != null
                    ? Icon(icon, color: color)
                    : CommonImage(imageSrc: imageSrc),
                CommonText(
                  text: title,
                  color: color,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  left: 16,
                ),
                const Spacer(),
                disableIcon
                    ? const SizedBox()
                    : Icon(Icons.arrow_forward_ios_outlined, size: 20.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
