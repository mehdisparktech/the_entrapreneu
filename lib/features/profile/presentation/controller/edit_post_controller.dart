import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:the_entrapreneu/features/home/presentation/controller/home_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/post_controller.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_response_model.dart';
import '../../../../services/api/api_service.dart';

class EditPostController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final selectDateController = TextEditingController();
  final selectTimeController = TextEditingController();
  final priceController = TextEditingController();

  var selectedImage = Rx<File?>(null);
  var existingImageUrl = ''.obs;
  var selectedCategory = ''.obs;
  var categoryId = ''.obs;
  var selectedSubCategory = ''.obs;
  var subCategoryId = ''.obs;
  var selectedPricingOption = ''.obs;
  var selectedPriorityLevel = ''.obs;
  RxString postId = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var isLoading = false.obs;
  var isFetchingData = true.obs;

  // Dynamic lists that will be populated from API
  var categories = <String>[].obs;
  var categoryMap = <String, String>{}.obs; // categoryName -> categoryId
  var subCategories = <String>[].obs;
  var subCategoryMap = <String, String>{}.obs; // subCategoryName -> subCategoryId

  // Fallback hardcoded lists
  final List<String> fallbackCategories = [
    'Home & Property',
    'Automotive Help',
    'Vehicles & Transport',
    'Personal Help',
    'Business & Tech',
    'Miscellanies',
  ];

  final List<String> fallbackSubCategories = [
    'Plumbing',
    'Electrical',
    'Carpentry',
    'Painting',
    'Cleaning',
  ];

  final List<String> priorityLevels = ['Emergency', 'High', 'Medium', 'Low'];

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      postId.value = Get.arguments.toString();
      fetchPostDetails();
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    stateController.dispose();
    cityController.dispose();
    selectDateController.dispose();
    selectTimeController.dispose();
    priceController.dispose();
    super.onClose();
  }

  Future<void> fetchPostDetails() async {
    try {
      isFetchingData.value = true;

      final response = await ApiService.get(
        'posts/${postId.value}',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {

          final data = responseData['data'];

          if (data is Map<String, dynamic>) {
            await _parsePostData(data);

            Get.snackbar(
              'Success',
              'Post details loaded',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else {
            throw Exception('Invalid data format received');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        final errorMessage = _getErrorMessage(response);
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch post details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isFetchingData.value = false;
    }
  }

  Future<void> _parsePostData(Map<String, dynamic> data) async {
    // Title and Description
    if (data['title'] != null) {
      titleController.text = data['title'].toString();
    }
    if (data['description'] != null) {
      descriptionController.text = data['description'].toString();
    }

    // State and City (if available in API response)
    if (data['state'] != null) {
      stateController.text = data['state'].toString();
    }
    if (data['city'] != null) {
      cityController.text = data['city'].toString();
    }

    // Image
    if (data['image'] != null) {
      final imageValue = data['image'];
      if (imageValue is String && imageValue.isNotEmpty) {
        existingImageUrl.value = imageValue;
      } else if (imageValue != null) {
        existingImageUrl.value = imageValue.toString();
      }
    }

    // Category - Handle dynamic category
    if (data['category'] != null) {
      final categoryValue = data['category'];
      String categoryName = '';
      String categoryIdValue = '';

      if (categoryValue is Map<String, dynamic>) {
        categoryIdValue = categoryValue['_id']?.toString() ?? '';
        categoryName = categoryValue['name']?.toString() ?? '';
      } else if (categoryValue is String) {
        categoryIdValue = categoryValue;
        categoryName = categoryValue;
      }

      if (categoryName.isNotEmpty && categoryIdValue.isNotEmpty) {
        categoryId.value = categoryIdValue;
        selectedCategory.value = categoryName;

        // Add to category map and list if not already present
        if (!categoryMap.containsKey(categoryName)) {
          categoryMap[categoryName] = categoryIdValue;
          categories.add(categoryName);
        }
      }
    }

    // Sub Category
    if (data['subCategory'] != null) {
      final subCategoryValue = data['subCategory'];
      String subCategoryName = '';
      String subCategoryIdValue = '';

      if (subCategoryValue is Map<String, dynamic>) {
        subCategoryIdValue = subCategoryValue['_id']?.toString() ?? '';
        subCategoryName = subCategoryValue['name']?.toString() ?? '';
      } else if (subCategoryValue is String) {
        subCategoryIdValue = subCategoryValue;
        subCategoryName = subCategoryValue;
      }

      if (subCategoryName.isNotEmpty && subCategoryIdValue.isNotEmpty) {
        subCategoryId.value = subCategoryIdValue;
        selectedSubCategory.value = subCategoryName;

        // Add to subCategory map and list if not already present
        if (!subCategoryMap.containsKey(subCategoryName)) {
          subCategoryMap[subCategoryName] = subCategoryIdValue;
          subCategories.add(subCategoryName);
        }
      }
    }

    // Initialize fallback lists if empty
    if (categories.isEmpty) {
      categories.assignAll(fallbackCategories);
    }
    if (subCategories.isEmpty) {
      subCategories.assignAll(fallbackSubCategories);
    }

    // Location
    if (data['lat'] != null) {
      try {
        latitude.value = double.tryParse(data['lat'].toString()) ?? 0.0;
      } catch (e) {
        latitude.value = 0.0;
      }
    }
    if (data['long'] != null) {
      try {
        longitude.value = double.tryParse(data['long'].toString()) ?? 0.0;
      } catch (e) {
        longitude.value = 0.0;
      }
    }

    // Service Date
    if (data['serviceDate'] != null) {
      try {
        String dateString = data['serviceDate'].toString();
        if (dateString.isNotEmpty) {
          DateTime date = DateTime.parse(dateString);
          selectDateController.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00.000Z";
        }
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

    // Service Time
    if (data['serviceTime'] != null) {
      selectTimeController.text = data['serviceTime'].toString();
    }

    // Price and Pricing Option
    if (data['price'] != null && data['price'].toString().isNotEmpty &&
        double.tryParse(data['price'].toString()) != 0) {
      priceController.text = data['price'].toString();
      selectedPricingOption.value = 'pay';
    } else {
      selectedPricingOption.value = 'free';
    }

    // Priority
    if (data['priority'] != null) {
      String priority = data['priority'].toString().toLowerCase();
      selectedPriorityLevel.value = _capitalizeFirst(priority);
    }
  }

  // Method to fetch categories from API (optional - if you want to populate all categories)
  Future<void> fetchCategoriesFromApi() async {
    try {
      final response = await ApiService.get('categories');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          final List<dynamic> categoryList = responseData['data'];
          categories.clear();
          categoryMap.clear();

          for (var category in categoryList) {
            if (category is Map<String, dynamic>) {
              String name = category['name']?.toString() ?? '';
              String id = category['_id']?.toString() ?? '';
              if (name.isNotEmpty && id.isNotEmpty) {
                categories.add(name);
                categoryMap[name] = id;
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Fallback to hardcoded categories
      categories.assignAll(fallbackCategories);
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String _getErrorMessage(dynamic response) {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return data['message']?.toString() ?? 'Failed to fetch post details';
      }
      return 'Failed to fetch post details';
    } catch (e) {
      return 'Failed to fetch post details';
    }
  }

  // Get category ID from selected category name
  String getCategoryId(String categoryName) {
    return categoryMap[categoryName] ?? '';
  }

  // Get subCategory ID from selected subCategory name
  String getSubCategoryId(String subCategoryName) {
    return subCategoryMap[subCategoryName] ?? '';
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
      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}T00:00:00.000Z";
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
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      selectTimeController.text = "$hour:$minute $period";
    }
  }

  Future<void> updatePost() async {
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
      Get.snackbar('Error', 'Please select a category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (selectedPriorityLevel.value.isEmpty) {
      Get.snackbar('Error', 'Please select priority level',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;

      String priorityValue = selectedPriorityLevel.value.toUpperCase();
      String currentCategoryId = getCategoryId(selectedCategory.value);
      String currentSubCategoryId = getSubCategoryId(selectedSubCategory.value);

      final body = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': currentCategoryId,
        'lat': latitude.value.toString(),
        'long': longitude.value.toString(),
        'serviceDate': selectDateController.text,
        'serviceTime': selectTimeController.text,
        'priority': priorityValue,
        'state': stateController.text.trim(),
        'city': cityController.text.trim(),
      };

      // Add subCategory if available and selected
      if (currentSubCategoryId.isNotEmpty && selectedSubCategory.value.isNotEmpty) {
        body['subCategory'] = currentSubCategoryId;
      }

      // Add price if 'pay' option is selected and price is provided
      if (selectedPricingOption.value == 'pay' &&
          priceController.text.trim().isNotEmpty) {
        body['price'] = priceController.text.trim();
      }

      ApiResponseModel response;

      if (selectedImage.value != null) {
        response = await ApiService.multipart(
          'posts/${postId.value}',
          method: 'PATCH',
          body: body,
          imageName: 'image',
          imagePath: selectedImage.value!.path,
        );
      } else {
        response = await ApiService.patch(
          '${ApiEndPoint.baseUrl}/posts/${postId.value}',
          body: body,
        );
      }
      if(response.statusCode==200){
        Get.snackbar("Successful", "Update Your Post Data");
        Get.find<HomeController>().fetchPosts();
        Get.find<MyPostController>().fetchMyPosts();
      }


      _handleUpdateResponse(response);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to update post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _handleUpdateResponse(dynamic response) {
    isLoading.value = false;

    try {
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final success = responseData['success'] ?? false;
          final message = responseData['message']?.toString() ?? 'Post updated successfully!';

          if (success == true) {
            Get.snackbar(
              'Success',
              message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.back(result: true);
          } else {
            Get.snackbar(
              'Error',
              message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            'Success',
            'Post updated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.back(result: true);
        }
      } else {
        final errorMessage = _getErrorMessage(response);
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process response: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}