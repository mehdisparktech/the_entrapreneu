import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/notification_model.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../utils/constants/app_colors.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Sender Profile Image
          if (item.sender != null)
            Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(item.sender!.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          /// Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Notification Title
                    Expanded(
                      child: CommonText(
                        text: item.title,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),

                    /// Read Status Indicator
                    if (!item.read)
                      Container(
                        width: 8.w,
                        height: 8.h,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 4.h),

                /// Notification Text
                CommonText(
                  text: item.text,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  color: AppColors.black,
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: 4.h),

                /// Sender Name and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.sender != null)
                      CommonText(
                        text: item.sender!.name,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                        textAlign: TextAlign.start,
                      ),

                    /// Notification Time
                    CommonText(
                      text: item.createdAt.checkTime,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      color: AppColors.black.withOpacity(0.6),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
