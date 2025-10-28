import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/app_bar/custom_appbar.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/features/home/presentation/controller/post_job_controller.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';

class PostJobScreen extends StatelessWidget {
  PostJobScreen({super.key});

  final PostJobController controller = Get.put(PostJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: "Create Post",
                  showBackButton: true,
                ),
                SizedBox(height: 20.h),

                // Upload Image Section
                Obx(() {
                  if (controller.selectedImage.value != null) {
                    return Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.file(
                              controller.selectedImage.value!,
                              width: double.infinity,
                              height: 150.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: () {
                                controller.selectedImage.value = null;
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () => controller.showImagePicker(context),
                    child: Container(
                      height: 120.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColors.primaryColor,
                              size: 40.sp,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          CommonText(
                            text: "Upload Image",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20.h),

                // Title
                CommonText(
                  text: "Title",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 6.h),
                _buildTextField(
                  controller: controller.titleController,
                  hintText: "I Need Plumber",
                ),
                SizedBox(height: 16.h),

                // Description
                CommonText(
                  text: "Description",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 5.h),
                _buildTextField(
                  controller: controller.descriptionController,
                  hintText: "About The Role\nWe Are Looking For A Skilled And Reliable Plumber To Join Our Team. The Ideal Candidate Will Have Experience In Installing, Repairing, And Monitoring Residential And/Or Commercial Plumbing Systems.",
                  maxLines: 5,
                ),
                SizedBox(height: 16.h),

                // Category
                CommonText(
                  text: "Category",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 6.h),
                Obx(() {
                  if (controller.isCategoryLoading.value) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.textSecond),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                          ),
                        ),
                      ),
                    );
                  }

                  return _buildDropdown(
                    value: controller.selectedCategory.value.isEmpty
                        ? null
                        : controller.selectedCategory.value,
                    hint: "Select Category",
                    icon: Icons.home,
                    items: controller.categories,
                    onChanged: (value) {
                      controller.onCategoryChanged(value!);
                    },
                  );
                }),
                SizedBox(height: 16.h),

                // Sub Category
                CommonText(
                  text: "Sub Category",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                Obx(() => _buildDropdown(
                  value: controller.selectedSubCategory.value.isEmpty
                      ? null
                      : controller.selectedSubCategory.value,
                  hint: "Select Sub Category",
                  icon: Icons.build,
                  items: controller.subCategories,
                  onChanged: controller.subCategories.isEmpty
                      ? null
                      : (value) {
                    controller.selectedSubCategory.value = value!;
                  },
                )),
                SizedBox(height: 16.h),

                // Address
                CommonText(
                  text: "Address",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 6.h),
                _buildTextField(
                  controller: controller.addressController,
                  hintText: "8502 Preston Rd. Inglewood, Maine",
                  suffixIcon: Icons.my_location,
                ),
                SizedBox(height: 16.h),

                // Location Info
                Obx(() {
                  if (controller.latitude.value != 0.0 && controller.longitude.value != 0.0) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Location obtained: ${controller.latitude.value.toStringAsFixed(4)}, ${controller.longitude.value.toStringAsFixed(4)}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // Service Date
                CommonText(
                  text: "Service Date",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 6.h),
                _buildTextField(
                  controller: controller.serviceDateController,
                  hintText: "01 January 2000",
                  suffixIcon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () => controller.selectServiceDate(context),
                ),
                SizedBox(height: 16.h),

                // Service Time
                CommonText(
                  text: "Service Time",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 6.h),
                _buildTextField(
                  controller: controller.serviceTimeController,
                  hintText: "09:00 AM",
                  suffixIcon: Icons.access_time,
                  readOnly: true,
                  onTap: () => controller.selectServiceTime(context),
                ),
                SizedBox(height: 16.h),

                // Pricing / Fee Options
                CommonText(
                  text: "Pricing / Fee Options",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 6.h),
                Obx(() => Row(
                  children: [
                    Expanded(
                      child: _buildPricingOption(
                        title: "Pay",
                        isSelected: controller.selectedPricingOption.value == 'pay',
                        onTap: () => controller.selectPricingOption('pay'),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _buildPricingOption(
                        title: "Accepting Offer",
                        isSelected: controller.selectedPricingOption.value == 'accepting_offer',
                        onTap: () => controller.selectPricingOption('accepting_offer'),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _buildPricingOption(
                        title: "Free",
                        isSelected: controller.selectedPricingOption.value == 'free',
                        onTap: () => controller.selectPricingOption('free'),
                      ),
                    ),
                  ],
                )),

                // Price field (show only when Pay is selected)
                Obx(() {
                  if (controller.selectedPricingOption.value == 'pay') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        _buildTextField(
                          controller: controller.priceController,
                          hintText: "\$100",
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
                SizedBox(height: 16.h),

                // Priority Level
                CommonText(
                  text: "Priority Level",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                Obx(() => _buildDropdown(
                  value: controller.selectedPriorityLevel.value.isEmpty
                      ? null
                      : controller.selectedPriorityLevel.value,
                  hint: "Select Priority",
                  items: controller.priorityLevels,
                  onChanged: (value) {
                    controller.selectedPriorityLevel.value = value!;
                  },
                )),
                SizedBox(height: 32.h),

                // Post Button
                Obx(() {
                  return CommonButton(
                    titleText: controller.isLoading.value ? "Posting..." : "Post",
                    buttonColor: AppColors.primaryColor,
                    buttonRadius: 8,
                    onTap: controller.isLoading.value ? null : () => controller.createPost(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.textSecond),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[400],
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.grey[600], size: 20.sp)
              : null,
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    IconData? icon,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.textSecond),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20.sp, color: Colors.grey[700]),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(
                  hint,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                ),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                items: items.isEmpty
                    ? null
                    : items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: items.isEmpty ? null : onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey[300]!,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}