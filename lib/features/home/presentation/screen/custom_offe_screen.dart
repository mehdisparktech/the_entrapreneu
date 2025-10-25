import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import '../controller/custom_offer_controller.dart';

class CustomOfferScreen extends StatelessWidget {
  CustomOfferScreen({super.key});

  final CustomOfferController controller = Get.put(CustomOfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: CommonText(
          text: "Custom Offer",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Letter Section
              CommonText(
                text: "Cover Letter",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 12.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: controller.coverLetterController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'I Am Writing To Express My Interest In The Plumber Position At [Company Name], With Hands-On Experience In Installing, Repairing, And Maintaining Residential And Commercial Plumbing Systems, I Am Confident That My Skills And Dedication Will Provide High-Quality And Reliable Service.',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.w),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Budget Section
              CommonText(
                text: "Budget",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 12.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: controller.budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '\$',
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Attach Document Section
              CommonText(
                text: "Attach Document",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 12.h),
              Obx(() {
                if (controller.selectedFile.value != null) {
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            controller.selectedFile.value!,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.insert_drive_file,
                                  color: AppColors.primaryColor,
                                  size: 28.sp,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: controller.selectedFileName.value,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                maxLines: 1,
                              ),
                              SizedBox(height: 4.h),
                              CommonText(
                                text: controller.formatFileSize(
                                    controller.selectedFileSize.value),
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                          onPressed: () => controller.removeDocument(),
                        ),
                      ],
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () => controller.showDocumentPicker(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cloud_upload_outlined,
                            color: AppColors.primaryColor,
                            size: 40.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CommonText(
                          text: "Upload Image / PDF",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 32.h),

              // Submit Button
              Obx(() {
                return CommonButton(
                  titleText: controller.isLoading.value
                      ? "Submitting..."
                      : "Submit",
                  buttonColor: AppColors.primaryColor,
                  buttonRadius: 8,
                  onTap: controller.isLoading.value
                      ? null
                      : () => controller.submitOffer(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}