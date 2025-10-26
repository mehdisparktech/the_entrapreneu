import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  // Text Controllers
  final fullNameController = TextEditingController();
  final aboutController = TextEditingController();
  final designationController = TextEditingController();
  final experienceController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final skillController = TextEditingController();

  // Observable variables
  var profileImage = Rx<String?>(null);
  var skills = <String>[].obs;
  var selectedGender = 'Male'.obs;
  var dateOfBirth = Rx<DateTime?>(null);

  // Dropdown options
  final genderOptions = ['Male', 'Female', 'Other'];

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Initialize with default values
    fullNameController.text = 'Shakir Ahmed';
    aboutController.text = 'Skilled professionals offering reliable, on-demand services to meet your everyday needs quickly and efficiently.';
    designationController.text = 'Electrician';
    experienceController.text = '5 Years';
    stateController.text = 'California';
    cityController.text = 'Bakersfield';
    skills.value = ['Electrician', 'House', 'Wiring'];
    dateOfBirth.value = DateTime(2000, 1, 1);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    aboutController.dispose();
    designationController.dispose();
    experienceController.dispose();
    stateController.dispose();
    cityController.dispose();
    skillController.dispose();
    super.onClose();
  }

  // Method to pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        profileImage.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        profileImage.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to show image picker options
  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Get.back();
                pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  // Method to add skill
  void addSkill() {
    if (skillController.text.trim().isNotEmpty) {
      if (!skills.contains(skillController.text.trim())) {
        skills.add(skillController.text.trim());
        skillController.clear();
      } else {
        Get.snackbar(
          'Duplicate Skill',
          'This skill is already added',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  // Method to remove skill
  void removeSkill(String skill) {
    skills.remove(skill);
  }

  // Method to pick date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth.value ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E5AA8),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateOfBirth.value = picked;
    }
  }

  // Method to format date
  String getFormattedDate() {
    if (dateOfBirth.value == null) return 'Select Date';
    final date = dateOfBirth.value!;
    return '${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  // Validation and update method
  void updateProfile() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your full name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (skills.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please add at least one skill',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (aboutController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter about yourself',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (designationController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your designation',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (dateOfBirth.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select your date of birth',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (experienceController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your experience',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (stateController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your state',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (cityController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your city',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: Implement API call
    print('Full Name: ${fullNameController.text}');
    print('Skills: ${skills.join(", ")}');
    print('About: ${aboutController.text}');
    print('Designation: ${designationController.text}');
    print('DOB: ${getFormattedDate()}');
    print('Gender: ${selectedGender.value}');
    print('Experience: ${experienceController.text}');
    print('State: ${stateController.text}');
    print('City: ${cityController.text}');
    print('Profile Image: ${profileImage.value}');

    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.back();
  }
}