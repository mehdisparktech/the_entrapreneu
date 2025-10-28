import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_entrapreneu/features/home/presentation/widgets/posts_complete.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/app_colors.dart';
//import '../../../../core/service/api_service.dart';
import '../../../../config/api/api_end_point.dart';

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
  var selectedCategoryId = ''.obs;
  var selectedSubCategory = ''.obs;
  var selectedPricingOption = ''.obs; // 'pay', 'accepting_offer', 'free'
  var selectedPriorityLevel = ''.obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var isLoading = false.obs;
  var isCategoryLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Category options - will be populated from API
  var categories = <String>[].obs;
  var categoryMap = <String, String>{}.obs; // name -> id mapping
  var categorySubCategoryMap = <String, List<String>>{}.obs; // id -> subcategories

  // Sub category options - will be updated based on selected category
  var subCategories = <String>[].obs;

  // Priority levels
  final List<String> priorityLevels = ['EMERGENCY', 'HIGH', 'MEDIUM', 'LOW'];

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
    fetchCategories();
  }

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

  /// Get current location
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Error',
          'Location services are disabled. Please enable them.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            'Error',
            'Location permission denied',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Error',
          'Location permissions are permanently denied',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      print('Location obtained: ${latitude.value}, ${longitude.value}');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get location: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Fetch categories from API
  Future<void> fetchCategories() async {
    try {
      isCategoryLoading.value = true;

      final response = await ApiService.get(
        ApiEndPoint.category, // Replace with your actual endpoint
        header: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> categoryData = response.data['data'];

        categories.clear();
        categoryMap.clear();
        categorySubCategoryMap.clear();

        for (var category in categoryData) {
          String categoryName = category['name'];
          String categoryId = category['_id'];
          List<String> subCats = List<String>.from(category['subCategories'] ?? []);

          categories.add(categoryName);
          categoryMap[categoryName] = categoryId;
          categorySubCategoryMap[categoryId] = subCats;
        }

        print('Categories loaded: ${categories.length}');
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Failed to load categories',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch categories: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isCategoryLoading.value = false;
    }
  }

  /// Update subcategories when category is selected
  void onCategoryChanged(String categoryName) {
    selectedCategory.value = categoryName;
    selectedCategoryId.value = categoryMap[categoryName] ?? '';

    // Update subcategories based on selected category
    subCategories.value = categorySubCategoryMap[selectedCategoryId.value] ?? [];

    // Clear selected subcategory
    selectedSubCategory.value = '';
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
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
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

    if (selectedCategory.value.isEmpty) {
      Get.snackbar('Error', 'Please select category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (selectedSubCategory.value.isEmpty) {
      Get.snackbar('Error', 'Please select sub category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (latitude.value == 0.0 || longitude.value == 0.0) {
      Get.snackbar('Error', 'Location not available. Please enable location.',
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
    }

    try {
      isLoading.value = true;

      // Prepare form data
      Map<String, String> body = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': selectedCategoryId.value,
        'subCategory': selectedSubCategory.value,
        'lat': latitude.value.toString(),
        'long': longitude.value.toString(),
        'serviceDate': serviceDateController.text.isNotEmpty
            ? _formatDateForAPI(serviceDateController.text)
            : '',
        'serviceTime': serviceTimeController.text,
        'price': selectedPricingOption.value == 'pay'
            ? priceController.text.trim()
            : '0',
        'priority': selectedPriorityLevel.value.isNotEmpty
            ? selectedPriorityLevel.value
            : 'MEDIUM',
      };

      // API call with image
      final response = await ApiService.multipartImage(
        ApiEndPoint.post, // Replace with your actual endpoint
        body: body,
        method: 'POST',
        files: selectedImage.value != null
            ? [
          {
            'name': 'image',
            'image': selectedImage.value!.path,
          }
        ]
            : [],
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success dialog
        PostPublishingDialog.show(
          Get.context!,
          onComplete: () {
            // Clear form
            _clearForm();
            // Navigate back
            Get.back();
          },
        );
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Failed to create post',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to create post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _formatDateForAPI(String displayDate) {
    // Convert "01 January 2000" to "2025-10-30T00:00:00.000Z" format
    try {
      final parts = displayDate.split(' ');
      final day = parts[0];
      final month = _getMonthNumber(parts[1]);
      final year = parts[2];
      return '$year-$month-${day}T00:00:00.000Z';
    } catch (e) {
      return '';
    }
  }

  String _getMonthNumber(String monthName) {
    const months = {
      'January': '01',
      'February': '02',
      'March': '03',
      'April': '04',
      'May': '05',
      'June': '06',
      'July': '07',
      'August': '08',
      'September': '09',
      'October': '10',
      'November': '11',
      'December': '12',
    };
    return months[monthName] ?? '01';
  }

  void _clearForm() {
    titleController.clear();
    descriptionController.clear();
    addressController.clear();
    serviceDateController.clear();
    serviceTimeController.clear();
    priceController.clear();
    selectedImage.value = null;
    selectedCategory.value = '';
    selectedCategoryId.value = '';
    selectedSubCategory.value = '';
    selectedPricingOption.value = '';
    selectedPriorityLevel.value = '';
  }
}