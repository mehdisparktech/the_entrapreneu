import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class CustomOfferController extends GetxController {
  final coverLetterController = TextEditingController();
  final budgetController = TextEditingController();

  var selectedFile = Rx<File?>(null);
  var selectedFileName = ''.obs;
  var selectedFileSize = 0.obs;
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    coverLetterController.dispose();
    budgetController.dispose();
    super.onClose();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        File file = File(image.path);
        selectedFile.value = file;
        selectedFileName.value = image.name;
        selectedFileSize.value = await file.length();

        Get.back(); // Close bottom sheet

        Get.snackbar(
          'Success',
          'Image selected: ${image.name}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        File file = File(image.path);
        selectedFile.value = file;
        selectedFileName.value = image.name;
        selectedFileSize.value = await file.length();

        Get.back(); // Close bottom sheet

        Get.snackbar(
          'Success',
          'Photo captured: ${image.name}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture photo: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeDocument() {
    selectedFile.value = null;
    selectedFileName.value = '';
    selectedFileSize.value = 0;
  }

  void showDocumentPicker() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            CommonText(
              text: "Select Document",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.photo_library,
                  color: AppColors.primaryColor,
                ),
              ),
              title: CommonText(
                text: "Choose from Gallery",
                fontSize: 16.sp,
              ),
              onTap: () => pickImageFromGallery(),
            ),
            SizedBox(height: 10.h),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: AppColors.primaryColor,
                ),
              ),
              title: CommonText(
                text: "Take Photo",
                fontSize: 16.sp,
              ),
              onTap: () => pickImageFromCamera(),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> submitOffer() async {
    // Validation
    if (coverLetterController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter cover letter',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (budgetController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter budget',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar(
      'Success',
      'Offer submitted successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Clear form
    coverLetterController.clear();
    budgetController.clear();
    selectedFile.value = null;
    selectedFileName.value = '';
    selectedFileSize.value = 0;

    // Navigate back
    Get.back();
  }
}