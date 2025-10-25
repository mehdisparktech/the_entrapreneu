import 'package:flutter/material.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({
    super.key,
    required this.notificationCount,
  });

  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: CommonImage(
                imageSrc: AppImages.profileImage,
                size: 40,
                defaultImage: AppImages.profileImage,
              ),
            ),
            12.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Shakir Ahmed",
                  fontSize: 16,
                  color: AppColors.textColorFirst,
                  fontWeight: FontWeight.w600,
                ),
                CommonText(
                  text: "Electrician",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            )
          ],
        ),
        // Notification icon with badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_outlined,
                size: 28,
              ),
            ),
            if (notificationCount > 0)
              Positioned(
                right: 4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Center(
                    child: Text(
                      "$notificationCount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}