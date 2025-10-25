import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/component/text_field/common_text_field.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import 'package:the_entrapreneu/utils/constants/app_string.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: 'Help & Support',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: _bodySection(),
    );
  }

  /// Body Section starts here
  Widget _bodySection() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameField(),
          SizedBox(height: 16.h),
          _buildDescriptionField(),
          SizedBox(height: 16.h),
          _buildAttachFileSection(),
          SizedBox(height: 24.h),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  /// Name field
  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Reason',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: _nameController,
          borderRadius: 8.r,
          hintText: 'Enter your Reason',
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppString.thisFieldIsRequired;
            }
            return null;
          },
        ),
      ],
    );
  }

  /// Description field
  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Description',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: _descriptionController,
          hintText:
              'If you are having trouble to sign in with Account then you can Email us in Account Issues or Choosing Other Issue Regarding',
          textInputAction: TextInputAction.newline,
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          borderRadius: 8.r,
        ),
      ],
    );
  }

  /// Attach file section
  Widget _buildAttachFileSection() {
    return InkWell(
      onTap: () {
        // Handle file attachment
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 17),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: const Color(0xFFD1D5D6)),
            borderRadius: BorderRadius.circular(11),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 50,
              offset: Offset(20, 20),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            CommonImage(imageSrc: AppIcons.attachment, width: 24, height: 24),
            8.width,
            CommonText(
              text: 'Attach File',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  /// Submit button
  Widget _buildSubmitButton() {
    return CommonButton(
      titleText: 'Submit',
      onTap: () {
        // Handle submit action
      },
    );
  }
}
