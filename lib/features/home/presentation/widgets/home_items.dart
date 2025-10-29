import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_entrapreneu/config/api/api_end_point.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/data_model.dart';

class HomeItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Post post;

  const HomeItem({super.key, required this.onTap, required this.post});

  String _getImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    return ApiEndPoint.imageUrl +
        imagePath; // Replace with your actual base URL
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170.w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: /*CommonImage(
                imageSrc: _getImageUrl(post.image),
                height: 100.h,
                width: 145.w,
                imageType: ImageType.network,
              ),*/ Image.network(
                _getImageUrl(post.image),
                height: 100.h,
                width: 145.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5.h),
            CommonText(
              text: "\$${post.price}",
              fontSize: 20,
              color: AppColors.checkColor,
              fontWeight: FontWeight.w600,
            ),
            CommonText(
              text: post.title,
              fontSize: 12,
              color: AppColors.primaryWork,
              fontWeight: FontWeight.w600,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            CommonText(
              text: post.user.name,
              fontSize: 12,
              color: AppColors.primaryWork,
              fontWeight: FontWeight.w400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
