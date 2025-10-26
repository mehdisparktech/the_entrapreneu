import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/features/profile/presentation/screen/edit_service_provider_profile.dart';

import '../controller/provider_info_controller.dart';

class ServiceProviderInfoScreen extends StatelessWidget {
  ServiceProviderInfoScreen({Key? key}) : super(key: key);

  final ServiceProviderController controller = Get.put(ServiceProviderController());

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
        title: const Text(
          'Service Provider Info',
          style: TextStyle(
            color: Color(0xFF1E5AA8),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Dropdown
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: InputBorder.none,
                  ),
                  hint: const Text('Select Category'),
                  items: controller.categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedCategory.value = newValue;
                    }
                  },
                ),
              )),

              const SizedBox(height: 20),

              // Sub Category Dropdown
              const Text(
                'Sub Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedSubCategory.value.isEmpty
                      ? null
                      : controller.selectedSubCategory.value,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: InputBorder.none,
                  ),
                  hint: const Text('Select Sub Category'),
                  items: controller.subCategories.map((String subCategory) {
                    return DropdownMenuItem<String>(
                      value: subCategory,
                      child: Text(subCategory),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedSubCategory.value = newValue;
                    }
                  },
                ),
              )),

              const SizedBox(height: 20),

              // Experience TextField
              const Text(
                'Experience',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: TextEditingController(text: controller.experience.value),
                  onChanged: (value) => controller.experience.value = value,
                  decoration: const InputDecoration(
                    hintText: 'Enter your experience',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Add Skills
              const Text(
                'Add Skills',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: controller.skillController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Skills',
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => controller.addSkill(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5AA8),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Skills chips
              Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.skills.map((skill) {
                  return Chip(
                    label: Text(
                      skill,
                      style: const TextStyle(fontSize: 13),
                    ),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => controller.removeSkill(skill),
                    backgroundColor: Colors.grey.shade200,
                  );
                }).toList(),
              )),

              const SizedBox(height: 40),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Get.to(EditProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5AA8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}