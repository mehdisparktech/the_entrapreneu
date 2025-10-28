import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/config/api/api_end_point.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../data/post_model.dart';

class PostCard extends StatelessWidget {
  final VoidCallback? onTap;
  final PostData postData;
  final Function(String)? onDelete;
  final Function(String)? onEdit;

  const PostCard({
    super.key,
    required this.onTap,
    required this.postData,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          /// মূল কার্ড
          Container(
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
                  child: postData.image != null && postData.image!.isNotEmpty
                      ? Image.network(
                    ApiEndPoint.imageUrl+postData.image!,
                    height: 100.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                  )
                      : CommonImage(
                    imageSrc: AppImages.detailsImage,
                    height: 100.h,
                    width: 145.w,
                  ),
                ),
                SizedBox(height: 5.h),
                CommonText(
                  text: "\$${postData.price ?? 0}",
                  fontSize: 20,
                  color: AppColors.checkColor,
                  fontWeight: FontWeight.w600,
                ),
                CommonText(
                  text: postData.title ?? 'No Title',
                  fontSize: 12,
                  color: AppColors.primaryWork,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                CommonText(
                  text: postData.category?.name ?? 'No Category',
                  fontSize: 12,
                  color: AppColors.primaryWork,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// উপরের ডান পাশে more আইকন
          Positioned(
            top: 10,
            right: 20,
            child: GestureDetector(
              onTapDown: (TapDownDetails details) async {
                final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                await showMenu(
                  context: context,
                  position: RelativeRect.fromRect(
                    details.globalPosition & const Size(40, 40),
                    Offset.zero & overlay.size,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  items: [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit, color: Colors.black54, size: 18),
                          SizedBox(width: 8.w),
                          const Text("Edit Post"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.redAccent, size: 18),
                          SizedBox(width: 8.w),
                          const Text("Delete Post"),
                        ],
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value == 'edit') {
                    if (onEdit != null) {
                      onEdit!(postData.id ?? '');
                    } else {
                      Get.toNamed(AppRoutes.editPost, arguments: postData);
                    }
                  } else if (value == 'delete') {
                    _showDeleteConfirmDialog(context, postData.id ?? '');
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
                child: const Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onDelete != null) {
                onDelete!(postId);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}