import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:the_entrapreneu/features/home/presentation/widgets/posts_complete.dart';

import '../../../../utils/constants/app_colors.dart';

class PostJobController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final serviceDateController = TextEditingController();
  final serviceTimeController = TextEditingController();
  final priceController = TextEditingController();

  var selectedImage = Rx<File?>(null);
  var selectedImageName = ''.obs;

  var selectedCategory = ''.obs;
  var selectedSubCategory = ''.obs;
  var selectedPricingOption = ''.obs; // 'pay', 'accepting_offer', 'free'
  var selectedPriorityLevel = ''.obs;

  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Category options
  final List<String> categories = [
    'Home & Property',
    'Automotive Help',
    'Vehicles & Transport',
    'Personal Help',
    'Business & Tech',
    'Miscellanies',
  ];

  // Sub category options
  final List<String> subCategories = [
    'Plumbing',
    'Electrical',
    'Carpentry',
    'Painting',
    'Cleaning',
  ];

  // Priority levels
  final List<String> priorityLevels = ['Emergency', 'High', 'Medium', 'Low'];

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    serviceDateController.dispose();
    serviceTimeController.dispose();
    priceController.dispose();
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
        selectedImage.value = file;
        selectedImageName.value = image.name;

        Get.back(); // Close bottom sheet

        Get.snackbar(
          'Success',
          'Image selected',
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
        selectedImage.value = file;
        selectedImageName.value = image.name;

        Get.back(); // Close bottom sheet

        Get.snackbar(
          'Success',
          'Photo captured',
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

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
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
              Text(
                "Select Image",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppColors.primaryColor,
                ),
                title: Text("Choose from Gallery"),
                onTap: () => pickImageFromGallery(),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
                title: Text("Take Photo"),
                onTap: () => pickImageFromCamera(),
              ),
            ],
          ),
        );
      },
    );
  }

  void selectPricingOption(String option) {
    selectedPricingOption.value = option;
  }

  Future<void> selectServiceDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      serviceDateController.text =
          "${picked.day.toString().padLeft(2, '0')} ${_getMonthName(picked.month)} ${picked.year}";
    }
  }

  Future<void> selectServiceTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'Am' : 'Pm';
      serviceTimeController.text = "$hour:$minute $period";
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  Future<void> createPost() async {
    // Validation
    /*if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter title',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }*/

    /*if (descriptionController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter description',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }*/

    /*if (selectedCategory.value.isEmpty) {
      Get.snackbar('Error', 'Please select category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (selectedPricingOption.value.isEmpty) {
      Get.snackbar('Error', 'Please select pricing option',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (selectedPricingOption.value == 'pay' && priceController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter price',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }*/

    PostPublishingDialog.show(
      Get.context!,
      onComplete: () {
        Get.snackbar(
          'Success',
          'Post published successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar(
      'Success',
      'Post created successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Clear form
    titleController.clear();
    descriptionController.clear();
    addressController.clear();
    serviceDateController.clear();
    serviceTimeController.clear();
    priceController.clear();
    selectedImage.value = null;
    selectedCategory.value = '';
    selectedSubCategory.value = '';
    selectedPricingOption.value = '';
    selectedPriorityLevel.value = '';

    // Navigate back
    Get.back();
  }
}
