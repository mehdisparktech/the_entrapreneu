import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/profile_controller.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_images.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';
import 'package:the_entrapreneu/features/profile/presentation/widgets/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          
          /// App Bar
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Get.back(),
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
            centerTitle: true,
            title: CommonText(
              text: 'Edit Profile',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),

          /// Body
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    20.height,

                    /// Profile Image
                    _buildProfileImage(controller),

                    32.height,

                    /// All Form Fields
                    EditProfileAllFiled(controller: controller),

                    32.height,

                    /// Update Button
                    CommonButton(
                      titleText: 'Update',
                      onTap: controller.editProfileRepo,
                      isLoading: controller.isLoading,
                      buttonColor: AppColors.primaryColor,
                      titleColor: AppColors.white,
                      buttonHeight: 56.h,
                      buttonRadius: 8.r,
                      titleSize: 16.sp,
                      titleWeight: FontWeight.w600,
                    ),

                    32.height,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Profile Image Widget
  Widget _buildProfileImage(ProfileController controller) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.white,
              width: 3.w,
            ),
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
            child: controller.image != null
                ? Image.file(
                    File(controller.image!),
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  )
                : CommonImage(
                    imageSrc: AppImages.profile,
                    width: 100.w,
                    height: 100.h,
                    fill: BoxFit.cover,
                  ),
          ),
        ),
        
        /// Edit Icon
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: controller.getProfileImage,
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2.w,
                ),
              ),
              child: Icon(
                Icons.edit,
                color: AppColors.white,
                size: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
