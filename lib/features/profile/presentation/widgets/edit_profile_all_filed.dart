import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/component/text_field/common_text_field.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/profile_controller.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';
import 'package:the_entrapreneu/utils/helpers/other_helper.dart';

class EditProfileAllFiled extends StatelessWidget {
  const EditProfileAllFiled({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Full Name Field
        _buildLabel('Full Name'),
        8.height,
        CommonTextField(
          controller: controller.nameController,
          validator: OtherHelper.validator,
          hintText: 'Shakir Ahmed',
          keyboardType: TextInputType.text,
          borderColor: AppColors.borderColor,
          fillColor: AppColors.white,
          hintTextColor: AppColors.secondaryText,
          textColor: AppColors.black,
        ),

        16.height,

        /// About Field
        _buildLabel('About'),
        8.height,
        CommonTextField(
          controller: controller.aboutController,
          hintText:
              'Skilled professionals offering reliable, on-demand services...',
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          borderColor: AppColors.borderColor,
          fillColor: AppColors.white,
          hintTextColor: AppColors.secondaryText,
          textColor: AppColors.black,
        ),

        16.height,

        /// Date of Birth Field
        _buildLabel('Date Of Birth'),
        8.height,
        CommonTextField(
          controller: controller.dateOfBirthController,
          hintText: '01 January 2000',
          keyboardType: TextInputType.none,
          borderColor: AppColors.borderColor,
          fillColor: AppColors.white,
          hintTextColor: AppColors.secondaryText,
          textColor: AppColors.black,
          onTap: controller.selectDateOfBirth,
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.secondaryText,
            size: 20.sp,
          ),
        ),

        16.height,

        /// Gender Field
        _buildLabel('Gender'),
        8.height,
        _buildGenderDropdown(),

        16.height,

        /// Address Field
        _buildLabel('Address'),
        8.height,
        CommonTextField(
          controller: controller.addressController,
          hintText: '8502 Preston Rd. Inglewood, Maine',
          keyboardType: TextInputType.text,
          borderColor: AppColors.borderColor,
          fillColor: AppColors.white,
          hintTextColor: AppColors.secondaryText,
          textColor: AppColors.black,
          suffixIcon: Icon(
            Icons.location_on_outlined,
            color: AppColors.secondaryText,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  /// Build Label Widget
  Widget _buildLabel(String text) {
    return CommonText(
      text: text,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      textAlign: TextAlign.start,
    );
  }

  /// Build Gender Dropdown
  Widget _buildGenderDropdown() {
    final genderOptions = ['Male', 'Female', 'Other'];
    
    // Normalize the current value to match dropdown items
    String? currentValue;
    if (controller.genderController.text.isNotEmpty) {
      final normalizedGender = controller.genderController.text.toLowerCase();
      currentValue = genderOptions.firstWhere(
        (option) => option.toLowerCase() == normalizedGender,
        orElse: () => '',
      );
      if (currentValue.isEmpty) currentValue = null;
    }
    
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          hintText: 'Male',
          hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.secondaryText),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.secondaryText,
          size: 24.sp,
        ),
        items: genderOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: CommonText(
              text: value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              textAlign: TextAlign.start,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.selectGender(newValue);
          }
        },
      ),
    );
  }
}
