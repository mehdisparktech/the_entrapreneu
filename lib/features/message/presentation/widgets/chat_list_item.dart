import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../utils/constants/app_colors.dart';


Widget chatListItem({required ChatModel item}) {
  return Container(
    padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
    decoration: const BoxDecoration(color: AppColors.transparent),
    child: Column(
      children: [
        Row(
          children: [
            /// participant image here
            CircleAvatar(
              radius: 35.sp,
              child: ClipOval(
                child: CommonImage(imageSrc: item.participant.image, size: 70),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// participant Name here
                  CommonText(
                    text: item.participant.fullName,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),

                  /// participant Last Message here
                  CommonText(
                    text: item.latestMessage.message,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
        16.height,

        /// Divider here
        const Divider(height: 1),
      ],
    ),
  );
}
