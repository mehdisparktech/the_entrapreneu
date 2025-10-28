import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/utils/extensions/custom_search.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/home_controller.dart';
import '../widgets/home_details.dart';
import '../widgets/home_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final int notificationCount = 5;

  void _showCreatePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => const CreatePostBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Container(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeDetails(notificationCount: notificationCount),
                      SizedBox(height: 20.h),
                      CustomSearchField(
                        onChanged: (value) {
                          controller.searchPosts(value);
                        },
                      ),
                      SizedBox(height: 20.h),
                      CommonButton(
                        titleText: "Create Post",
                        buttonRadius: 100,
                        buttonHeight: 40,
                        onTap: () => _showCreatePostBottomSheet(context),
                      ),
                      SizedBox(height: 24.h),

                      // Loading indicator
                      if (controller.isLoading)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.h),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      // Empty state
                      else if (controller.filteredPosts.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.h),
                            child: CommonText(
                              text: controller.searchQuery.isEmpty
                                  ? "No posts available"
                                  : "No results found",
                              fontSize: 16.sp,
                              color: AppColors.textColorFirst,
                            ),
                          ),
                        )
                      // Posts grid
                      else
                        GridView.builder(
                          itemCount: controller.filteredPosts.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 0.95,
                          ),
                          itemBuilder: (context, index) {
                            final post = controller.filteredPosts[index];
                            return HomeItem(
                              post: post,
                              onTap: () {
                                Get.toNamed(AppRoutes.createPost, arguments: post.id);
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreatePostBottomSheet extends StatelessWidget {
  const CreatePostBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'icon': "assets/icons/homeproperty_icon.svg",
        'label': 'Home & Property',
      },
      {'icon': "assets/icons/help_icon.svg", 'label': 'Automotive Help'},
      {
        'icon': "assets/icons/vhicales_icon.svg",
        'label': 'Vehicles & Transport',
      },
      {'icon': "assets/icons/personal_help.svg", 'label': 'Personal Help'},
      {'icon': "assets/icons/tech_icon.svg", 'label': 'Business & Tech'},
      {'icon': "assets/icons/miscellnis.svg", 'label': 'Miscellanies'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Create Post",
            fontSize: 20.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.postScreen);
                },
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors.blueLight,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          categories[index]['icon'] as String,
                          width: 24.w,
                          height: 24.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.textColorFirst,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: categories[index]['label'] as String,
                      fontSize: 20.sp,
                      color: AppColors.textColorFirst,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}