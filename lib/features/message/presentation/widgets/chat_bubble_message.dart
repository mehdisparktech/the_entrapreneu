import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';

class ChatBubbleMessage extends StatelessWidget {
  final DateTime time;
  final String text;
  final String image;
  final bool isMe;
  final int index;
  final String name;
  final VoidCallback onTap;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    required this.name,
    required this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('hh:mm a').format(time);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          /// Show profile image for received messages
          if (!isMe) ...[
            CircleAvatar(
              radius: 18.sp,
              backgroundColor: Colors.transparent,
              child: ClipOval(child: CommonImage(imageSrc: image, size: 36)),
            ),
            8.width,
          ], // Added comma here
          /// Message bubble
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                /// Show name for received messages
                if (!isMe)
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, bottom: 4.h),
                    child: CommonText(
                      text: name,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      textAlign: TextAlign.left,
                    ),
                  ),

                /// Message container
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Get.size.width * 0.5),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppColors.primaryColor
                          : const Color(0xFFF2F7FB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMe ? 16.r : 4.r),
                        topRight: Radius.circular(isMe ? 4.r : 16.r),
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: CommonText(
                      text: text,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isMe ? AppColors.white : AppColors.black,
                      textAlign: TextAlign.left,
                      maxLines: 100,
                    ),
                  ),
                ),

                /// Time stamp
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                  child: CommonText(
                    text: timeString,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
