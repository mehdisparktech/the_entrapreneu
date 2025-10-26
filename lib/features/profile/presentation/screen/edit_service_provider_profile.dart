import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/edit_service_provider_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final EditProfileController controller = Get.put(EditProfileController());

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
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Center(
                child: Stack(
                  children: [
                    Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(File(controller.profileImage.value!))
                          : null,
                      child: controller.profileImage.value == null
                          ? const Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                    )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => controller.showImagePickerOptions(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E5AA8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Full Name
              _buildLabel('Full Name'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: controller.fullNameController,
                hintText: 'Enter your full name',
              ),

              const SizedBox(height: 20),

              // Skills
              _buildLabel('Skills'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: controller.skillController,
                      hintText: 'Enter skill',
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => controller.addSkill(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5AA8),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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

              const SizedBox(height: 12),

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

              const SizedBox(height: 20),

              // About
              _buildLabel('About'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: controller.aboutController,
                hintText: 'Tell us about yourself',
                maxLines: 4,
              ),

              const SizedBox(height: 20),

              // Designation
              _buildLabel('Designation'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: controller.designationController,
                hintText: 'Enter your designation',
              ),

              const SizedBox(height: 20),

              // Date of Birth
              _buildLabel('Date of Birth'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => controller.pickDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                        controller.getFormattedDate(),
                        style: TextStyle(
                          fontSize: 14,
                          color: controller.dateOfBirth.value == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      )),
                      const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Gender
              _buildLabel('Gender'),
              const SizedBox(height: 8),
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedGender.value,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: controller.genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedGender.value = newValue;
                    }
                  },
                ),
              )),

              const SizedBox(height: 20),

              // Experience
              _buildLabel('Experience'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: controller.experienceController,
                hintText: 'Enter your experience',
              ),

              const SizedBox(height: 20),

              // State and City
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

              const SizedBox(height: 40),

              // Update Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => controller.updateProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5AA8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
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
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}