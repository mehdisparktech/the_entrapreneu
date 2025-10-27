import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/app_bar/custom_appbar.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/features/home/presentation/data/create_post_controller.dart';
import 'package:the_entrapreneu/features/home/presentation/widgets/message_details_dialog.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key});

  final CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final post = controller.post.value;
        if (post == null) {
          return const Center(child: Text('No post found'));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomAppBar(title: "View Post"),
                ),
                // User Info Card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Row
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundImage: AssetImage(
                                "assets/images/profile_image.png",
                              ),
                              backgroundColor: Colors.grey[300],
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: post.userName,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer_outlined,
                                        size: 14.sp,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 6),
                                      CommonText(
                                        text: "12 hours ago",
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 18.h),
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 14.sp,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 6),
                                      CommonText(
                                        text: "Dhaka, Bangladesh",
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Post Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: CommonImage(
                            imageSrc: "assets/images/view_image_pic.png",
                            height: 171.h,
                            width: 330.w,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Title and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: post.title,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CommonText(
                              text: post.price,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF5B26),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Location
                        CommonText(
                          text: post.location,
                          fontSize: 12.sp,
                          color: AppColors.textColorFirst,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 16.h),
                        // Category and Subcategory
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildInfoChip(Icons.category, post.category),
                          SizedBox(width: 12.w),
                          _buildInfoChip(Icons.work, post.subCategory),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Date and Time
                      Row(
                        children: [
                          _buildInfoChip(Icons.calendar_today, post.date),
                          SizedBox(width: 12.w),
                          _buildInfoChip(Icons.access_time, post.time),
                        ],
                      ),
                    ],
                  ),
                ),

                // About The Role Section
                _buildSection(
                  title: "About The Role",
                  content: post.description,
                ),

                // Requirements Section
                _buildListSection(
                  title: "Requirements",
                  items: post.requirements,
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CommonButton(
                    titleText: "Start Conversation",
                    buttonRadius: 10,
                    buttonColor: Color(0xFF008F37),
                    onTap: () => MessageDetailsDialog.show(
                      context,
                      onSend: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.textColorFirst),
          SizedBox(width: 6.w),
          CommonText(
            text: text,
            fontSize: 12.sp,
            color: AppColors.textColorFirst,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: title, fontSize: 16.sp, fontWeight: FontWeight.bold),
          SizedBox(height: 4.h),
          CommonText(
            text: content,
            fontSize: 14.sp,
            maxLines: 8,
            color: Colors.grey,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildListSection({
    required String title,
    required List<String> items,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: title, fontSize: 16.sp, fontWeight: FontWeight.bold),
          SizedBox(height: 12.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h, right: 8.w),
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  // ✅ Flexible দিয়ে wrap করো
                  Flexible(
                    child: CommonText(
                      text: item,
                      fontSize: 14.sp,
                      color: Colors.grey,
                      maxLines: 8,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
