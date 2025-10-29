import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/my_profile_controller.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_images.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProfileController>(
      init: MyProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: GestureDetector(
              onTap: controller.goBack,
              child: Container(
                margin: EdgeInsets.only(left: 20.w),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20.sp,
                ),
              ),
            ),
            leadingWidth: 50.w,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  20.height,

                  /// Profile Image
                  _buildProfileImage(controller),

                  16.height,

                  /// Name
                  CommonText(
                    text: controller.userName,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),

                  32.height,

                  /// About Section
                  _buildAboutSection(controller),

                  24.height,

                  /// Profile Details
                  _buildProfileDetails(controller),

                  32.height,

                  /// Edit Profile Button
                  _buildEditProfileButton(controller),

                  32.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Profile Image Widget
  Widget _buildProfileImage(MyProfileController controller) {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 4.w),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: controller.userImage.isNotEmpty
            ? CommonImage(
                imageSrc: controller.userImage,
                width: 120.w,
                height: 120.h,
                fill: BoxFit.cover,
              )
            : CommonImage(
                imageSrc: AppImages.profile,
                width: 120.w,
                height: 120.h,
                fill: BoxFit.cover,
              ),
      ),
    );
  }

  /// About Section Widget
  Widget _buildAboutSection(MyProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'About',
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          textAlign: TextAlign.start,
        ),
        8.height,
        CommonText(
          text: controller.about,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
          textAlign: TextAlign.start,
          maxLines: 10,
        ),
      ],
    );
  }

  /// Profile Details Widget
  Widget _buildProfileDetails(MyProfileController controller) {
    return Column(
      children: [
        _buildDetailRow('Mobile', controller.mobile),
        16.height,
        _buildDetailRow('E-mail', controller.userEmail),
        16.height,
        _buildDetailRow('Date o\' Birth', controller.dateOfBirth),
        16.height,
        _buildDetailRow('Gender', controller.gender),
        16.height,
        _buildDetailRow('Experience', controller.experience),
        16.height,
        _buildDetailRow('Address', controller.address),
      ],
    );
  }

  /// Detail Row Widget
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
          textAlign: TextAlign.start,
        ),
        Flexible(
          child: CommonText(
            text: value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
            textAlign: TextAlign.end,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  /// Edit Profile Button Widget
  Widget _buildEditProfileButton(MyProfileController controller) {
    return CommonButton(
      titleText: 'Edit Profile',
      onTap: controller.navigateToEditProfile,
      buttonColor: AppColors.primaryColor,
      titleColor: AppColors.white,
      buttonHeight: 56.h,
      buttonRadius: 8.r,
      titleSize: 16.sp,
      titleWeight: FontWeight.w600,
    );
  }
}
