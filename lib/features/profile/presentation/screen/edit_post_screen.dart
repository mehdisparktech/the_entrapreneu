import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../config/api/api_end_point.dart';
import '../controller/edit_post_controller.dart';

class EditPostScreen extends StatelessWidget {
  EditPostScreen({Key? key}) : super(key: key);

  final EditPostController controller = Get.put(EditPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Center(
          child: const Text(
            'Edit Post',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isFetchingData.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF1E5AA8),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Image Section
                Obx(() {
                  if (controller.selectedImage.value != null) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            controller.selectedImage.value!,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => controller.showImagePicker(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E5AA8),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // Show existing image from URL
                  if (controller.existingImageUrl.value.isNotEmpty) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: '${ApiEndPoint.imageUrl}${controller.existingImageUrl.value}',
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => controller.showImagePicker(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E5AA8),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // Default image placeholder with camera overlay
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(AppImages.noImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: () => controller.showImagePicker(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E5AA8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 20),

                // Title
                _buildLabel('Title'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: controller.titleController,
                  hintText: 'Enter title',
                ),

                const SizedBox(height: 16),

                // Description
                _buildLabel('Description'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: controller.descriptionController,
                  hintText: 'Enter description',
                  maxLines: 5,
                ),

                const SizedBox(height: 16),

                // Category
                _buildLabel('Category'),
                const SizedBox(height: 8),
                Obx(() => _buildDropdown(
                  value: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,
                  hint: 'Select category',
                  items: controller.categories,
                  onChanged: (value) {
                    controller.selectedCategory.value = value!;
                  },
                )),

                const SizedBox(height: 16),

                // Sub Category
                _buildLabel('Sub Category'),
                const SizedBox(height: 8),
                Obx(() => _buildDropdown(
                  value: controller.selectedSubCategory.value.isEmpty
                      ? null
                      : controller.selectedSubCategory.value,
                  hint: 'Select sub category',
                  items: controller.subCategories,
                  onChanged: (value) {
                    controller.selectedSubCategory.value = value!;
                  },
                )),

                const SizedBox(height: 16),

                // State and City Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('State'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: controller.stateController,
                            hintText: 'State',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('City'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: controller.cityController,
                            hintText: 'City',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Select Date
                _buildLabel('Select Date'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: controller.selectDateController,
                  hintText: 'Select date',
                  suffixIcon: Icons.calendar_today,
                  readOnly: true,
                  onTap: () => controller.selectDate(context),
                ),

                const SizedBox(height: 16),

                // Select Time
                _buildLabel('Select Time'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: controller.selectTimeController,
                  hintText: 'Select time',
                  suffixIcon: Icons.access_time,
                  readOnly: true,
                  onTap: () => controller.selectTime(context),
                ),

                const SizedBox(height: 16),

                // Pricing / Fee Options
                _buildLabel('Pricing / Fee Options'),
                const SizedBox(height: 8),
                Obx(() => Row(
                  children: [
                    Expanded(
                      child: _buildPricingOption(
                        title: 'Pay',
                        isSelected: controller.selectedPricingOption.value == 'pay',
                        onTap: () => controller.selectPricingOption('pay'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPricingOption(
                        title: 'Accepting Offer',
                        isSelected: controller.selectedPricingOption.value == 'accepting_offer',
                        onTap: () => controller.selectPricingOption('accepting_offer'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPricingOption(
                        title: 'Free',
                        isSelected: controller.selectedPricingOption.value == 'free',
                        onTap: () => controller.selectPricingOption('free'),
                      ),
                    ),
                  ],
                )),

                const SizedBox(height: 16),

                // Price field (only show if 'pay' is selected)
                Obx(() {
                  if (controller.selectedPricingOption.value == 'pay') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Price'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: controller.priceController,
                          hintText: 'Enter price',
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // Priority Level
                _buildLabel('Priority Level'),
                const SizedBox(height: 8),
                Obx(() => _buildDropdown(
                  value: controller.selectedPriorityLevel.value.isEmpty
                      ? null
                      : controller.selectedPriorityLevel.value,
                  hint: 'Select priority',
                  items: controller.priorityLevels,
                  onChanged: (value) {
                    controller.selectedPriorityLevel.value = value!;
                  },
                )),

                const SizedBox(height: 32),

                // Update Button
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.updatePost(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5AA8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E5AA8) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E5AA8) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xffE6EEFB) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E5AA8) : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primaryColor : const Color(0xFF1E5AA8),
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E5AA8).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1E5AA8),
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
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
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.grey[600], size: 20)
              : null,
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: TextStyle(fontSize: 14, color: Colors.grey[400])),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14, color: Colors.black)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E5AA8) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E5AA8) : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}