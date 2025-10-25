import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_entrapreneu/utils/enum/enum.dart';
import '../../../../component/text/common_text.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final StatusType type;

  const StatusBadge({super.key, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        // color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: CommonText(
        text: text,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: _getTextColor(),
      ),
    );
  }

  // Color _getBackgroundColor() {
  //   switch (type) {
  //     case StatusType.pending:
  //       return const Color(0xFFFFF3E0); // Light orange background
  //     case StatusType.complete:
  //       return const Color(0xFFE8F5E8); // Light green background
  //     case StatusType.upcoming:
  //       return const Color(0xFFE3F2FD); // Light blue background
  //   }
  // }

  Color _getTextColor() {
    switch (type) {
      case StatusType.running:
        return const Color(0xFFFF9800); // Orange text
      case StatusType.completed:
        return const Color(0xFF4CAF50); // Green text
      case StatusType.rejected:
        return const Color(0xFFF44336); // Red text
    }
  }
}
