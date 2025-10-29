import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../utils/constants/app_colors.dart';

Widget chatListItem({required ChatModel item}) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.only(bottom: 12),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shadows: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 2,
          offset: Offset(0, 2),
          spreadRadius: 0,
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            /// participant image here
            Stack(
              children: [
                CircleAvatar(
                  radius: 35.sp,
                  child: ClipOval(
                    child: CommonImage(
                      imageSrc: item.participant.image,
                      size: 70,
                    ),
                  ),
                ),
                if (item.status)
                  Positioned(
                    bottom: 6,
                    right: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0FE16D),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
              ],
            ),
            12.width,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          text: "Tap to view messages",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                  12.width,
                  CommonText(
                    text: item.latestMessage.createdAt.checkTime,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
