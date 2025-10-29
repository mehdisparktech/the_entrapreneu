import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../controller/sign_up_controller.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: CommonText(
          text: 'Complete Your Profile',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            // Profile Image Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: GetBuilder<SignUpController>(
                        builder: (controller) {
                          return controller.image != null
                              ? CommonImage(
                                  imageSrc: controller.image!,
                                  fill: BoxFit.cover,
                                )
                              : const CommonImage(
                                  imageSrc: AppImages.profile,
                                  fill: BoxFit.cover,
                                );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.openGallery(),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Date of Birth Field
            CommonText(
              text: 'Date of Birth',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              textAlign: TextAlign.left,
              bottom: 8,
            ),
            GestureDetector(
              onTap: () => controller.selectDate(context),
              child: AbsorbPointer(
                child: CommonTextField(
                  controller: controller.dateController,
                  hintText: '01 January 2000',
                  onTap: () => controller.selectDate(context),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.secondaryText,
                      size: 20.sp,
                    ),
                  ),
                  fillColor: AppColors.white,
                  hintTextColor: AppColors.black,
                  textColor: AppColors.black,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Gender Field
            CommonText(
              text: 'Gender',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              textAlign: TextAlign.left,
              bottom: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x19000000),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: controller.selectedGender,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.secondaryText,
                  size: 24.sp,
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                items: controller.genderOptions.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.selectedGender = newValue!;
                  controller.update();
                },
              ),
            ),

            SizedBox(height: 20.h),

            // Address Field
            CommonText(
              text: 'Address',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              textAlign: TextAlign.left,
              bottom: 8,
            ),
            CommonTextField(
              controller: controller.addressController,
              hintText: '8502 Preston Rd. Inglewood, Maine',
              suffixIcon: Padding(
                padding: EdgeInsets.all(12.w),
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.addLocation),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.secondaryText,
                    size: 20.sp,
                  ),
                ),
              ),
              fillColor: AppColors.white,
              hintTextColor: AppColors.black,
              textColor: AppColors.black,
            ),

            SizedBox(height: 40.h),

            // Confirm Button
            CommonButton(
              titleText: 'Confirm',
              onTap: () {
                controller.updateProfile();
                // Handle confirm action
              },
              buttonHeight: 48.h,
              titleSize: 16,
              titleWeight: FontWeight.w600,
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
