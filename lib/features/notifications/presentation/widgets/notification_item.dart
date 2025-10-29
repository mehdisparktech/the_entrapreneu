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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: item.type,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
            maxLines: 1,
          ),

          /// Notification Message here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CommonText(
                  text: item.message,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  color: AppColors.black,
                  textAlign: TextAlign.start,
                ),
              ),

              /// Notification Time here
              CommonText(
                text: item.createdAt.checkTime,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                color: AppColors.black,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
