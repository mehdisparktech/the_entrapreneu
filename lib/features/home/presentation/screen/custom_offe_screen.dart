import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/app_bar/custom_appbar.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/constants/success_dialog.dart';
import '../controller/custom_offer_controller.dart';

class CustomOfferScreen extends StatelessWidget {
  CustomOfferScreen({super.key});

  final CustomOfferController controller = Get.put(CustomOfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: "Custom Offer",
                  showBackButton: true,
                ),
                SizedBox(height: 20.h),

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
                      hintText: 'Type Here',
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
                      width: double.infinity,
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
                              width: 60.w,
                              height: 60.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    color: AppColors.primaryColor,
                                    size: 30.sp,
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
                                  maxLines: 2,
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
                              size: 24.sp,
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
                      height: 150.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColors.primaryColor,
                              size: 48.sp,
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
                  CommonButton(
                    titleText: "Submit",
                    buttonColor: AppColors.primaryColor,
                    buttonRadius: 8,
                    onTap: () {
                      SuccessDialog.show(
                        context,
                        title: "Success",
                        message: "Your custom offer has been submitted successfully.",
                        onPressed: () {
                          // এখানে success হলে যা করতে চাও
                          print("Dialog closed");
                        },
                      );
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}