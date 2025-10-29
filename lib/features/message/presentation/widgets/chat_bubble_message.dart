import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';

class ChatBubbleMessage extends StatelessWidget {
  final DateTime time;
  final String text;
  final String image;
  final String? messageImage; // Add this
  final bool isMe;
  final bool isUploading; // Add this
  final int index;
  final int messageIndex;

  final VoidCallback onTap;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    required this.text,
    required this.image,
    this.messageImage, // Add this
    required this.isMe,
    this.isUploading = false, // Add this
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
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 250.w,
                  ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Show image if exists
                      if (messageImage != null && messageImage!.isNotEmpty) ...[
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: messageImage!.startsWith('http')
                                  ? Image.network(
                                messageImage!,
                                width: 220.w,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 220.w,
                                    height: 200.h,
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 220.w,
                                    height: 200.h,
                                    color: Colors.grey[300],
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.broken_image,
                                          size: 40.sp,
                                          color: Colors.grey[600],
                                        ),
                                        SizedBox(height: 8.h),
                                        CommonText(
                                          text: "Failed to load",
                                          fontSize: 10.sp,
                                          color: Colors.grey[600]!,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                                  : Image.file(
                                File(messageImage!),
                                width: 220.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 220.w,
                                    height: 200.h,
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 40.sp,
                                      color: Colors.grey[600],
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Show uploading overlay
                            if (isUploading)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 30.w,
                                          height: 30.h,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        CommonText(
                                          text: "Uploading...",
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (text.isNotEmpty) SizedBox(height: 8.h),
                      ],
                      // Show text message
                      if (text.isNotEmpty)
                        CommonText(
                          text: text,
                          fontSize: 14.sp,
                          color: isMe ? Colors.white : Colors.black87,
                          maxLines: 100,
                          textAlign: TextAlign.justify,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                // Time stamp
                CommonText(
                  text: DateFormat('hh:mm a').format(time),
                  fontSize: 11.sp,
                  color: Colors.grey[600]!,
                ),
              ],
            ),
          ),

          // Right side: My message
          if (isMe) SizedBox(width: 8.w),
        ],
      ),
    );
  }
}