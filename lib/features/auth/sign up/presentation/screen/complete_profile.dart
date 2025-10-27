import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/features/auth/sign%20up/presentation/widget/success_profile.dart';
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
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedGender = 'Male';
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    dateController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

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
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: CommonTextField(
                  controller: dateController,
                  hintText: '01 January 2000',
                  onTap: () => _selectDate(context),
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
                value: selectedGender,
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
                items: genderOptions.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
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
              controller: addressController,
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
                // Handle confirm action
                SuccessProfileDialogHere.show(Get.context!, title: "Your Registration Successfully Complete.");
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
