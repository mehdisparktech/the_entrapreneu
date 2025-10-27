import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditPostController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final selectDateController = TextEditingController();
  final selectTimeController = TextEditingController();

  var selectedImage = Rx<File?>(null);
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
  void onInit() {
    super.onInit();
    // Initialize with default values
    titleController.text = 'I Need Plumber';
    descriptionController.text = 'About The Role\nWe Are Looking For A Skilled And Reliable Plumber To Join Our Team. The Ideal Candidate Will Have Experience In Installing, Repairing, And Monitoring Residential And/Or Commercial Plumbing Systems.';
    selectedCategory.value = 'Home & Property';
    selectedSubCategory.value = 'Plumbing';
    stateController.text = 'California';
    cityController.text = 'Bakersfield';
    selectDateController.text = '01 January 2000';
    selectTimeController.text = '09:00 Am';
    selectedPricingOption.value = 'pay';
    selectedPriorityLevel.value = 'Emergency';
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    stateController.dispose();
    cityController.dispose();
    selectDateController.dispose();
    selectTimeController.dispose();
    super.onClose();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
        Get.back();
        Get.snackbar(
          'Success',
          'Image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
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
        selectedImage.value = File(image.path);
        Get.back();
        Get.snackbar(
          'Success',
          'Photo captured',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Select Image",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF1E5AA8)),
                title: const Text("Choose from Gallery"),
                onTap: () => pickImageFromGallery(),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF1E5AA8)),
                title: const Text("Take Photo"),
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF1E5AA8)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectDateController.text =
      "${picked.day.toString().padLeft(2, '0')} ${_getMonthName(picked.month)} ${picked.year}";
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF1E5AA8)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'Am' : 'Pm';
      selectTimeController.text = "$hour:$minute $period";
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void updatePost() {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter title',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter description',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    // TODO: Implement API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Post updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    });
  }
}