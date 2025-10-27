import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';

class ChatBubbleMessage extends StatelessWidget {
  final DateTime time;
  final String text;
  final String image;
  final bool isMe;
  final int index;
  final int messageIndex;

  final VoidCallback onTap;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    required this.onTap,
    this.index = 0,
    this.messageIndex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Other person's message
          if (!isMe) ...[
            // Profile picture for other person
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.grey[300],
              backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
              child: image.isEmpty
                  ? Icon(Icons.person, size: 16.sp, color: Colors.grey[600])
                  : null,
            ),
            SizedBox(width: 8.w),
          ],

          // Message bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMe ? 16.r : 4.r),
                  topRight: Radius.circular(isMe ? 4.r : 16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CommonText(
                text: text,
                fontSize: 14.sp,
                color: isMe ? Colors.white : Colors.black87,
                maxLines: 100,
                textAlign: TextAlign.justify,
              ),
            ),
          ),

          // Right side: My message
          if (isMe) SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
