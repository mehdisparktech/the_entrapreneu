import 'package:flutter/material.dart';
import 'package:the_entrapreneu/features/home/presentation/widgets/offer_dialog.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../message/data/model/chat_message_model.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../message/presentation/widgets/chat_bubble_message.dart';
import '../controller/first_message_controller.dart';

class FirstMessage extends StatefulWidget {
  const FirstMessage({super.key});

  @override
  State<FirstMessage> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<FirstMessage> {
  String chatId = Get.parameters["chatRoomId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";

  String _getImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    return 'https://your-api-base-url.com$imagePath'; // Replace with your actual base URL
  }

  @override
  void initState() {
    FirstMessageController.instance.name = name;
    FirstMessageController.instance.chatId = chatId;
    FirstMessageController.instance.getMessageRepo();
    super.initState();
  }

  void _showAttachmentOptions() {
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
              CommonText(
                text: "Select Attachment",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.photo_library,
                    color: AppColors.primaryColor,
                    size: 24.sp,
                  ),
                ),
                title: CommonText(text: "Choose from Gallery", fontSize: 16.sp),
                onTap: () async {
                  Get.back();
                  await FirstMessageController.instance.pickImageFromGallery();
                },
              ),
              SizedBox(height: 10.h),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryColor,
                    size: 24.sp,
                  ),
                ),
                title: CommonText(text: "Take Photo", fontSize: 16.sp),
                onTap: () async {
                  Get.back();
                  await FirstMessageController.instance.pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstMessageController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[100],

          /// App Bar
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: CommonText(
              text: "Chat & Offer",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            centerTitle: true,
          ),

          /// 🟢 Full Scrollable Body
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: controller.scrollController,
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    children: [
                      /// Banner Section
                      InkWell(
                        onTap: () => OfferDialog.show(
                          Get.context!,
                          budget: 100,
                          serviceDate: DateTime.now(),
                          serviceTime: "",
                          onSubmit: () {},
                        ),
                        child: Container(
                          margin: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.r),
                                ),
                                child: Image.network(
                                  _getImageUrl(
                                    ApiEndPoint.imageUrl +
                                        controller.post!.image,
                                  ),
                                  height: 171.h,
                                  width: 330.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: controller.post!.title,
                                          fontSize: 14.sp,
                                          color: AppColors.textColorFirst,
                                          fontWeight: FontWeight.w600,
                                          maxLines: 2,
                                        ),
                                        CommonText(
                                          text: "\$${controller.post!.price}",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                    6.height,
                                    CommonText(
                                      text: "California, Fresno",
                                      fontSize: 12.sp,
                                      color: AppColors.textColorFirst,
                                    ),
                                    12.height,
                                    GestureDetector(
                                      onTap: () => OfferDialog.show(
                                        Get.context!,
                                        budget: 100,
                                        serviceDate: DateTime.now(),
                                        serviceTime: "",
                                        onSubmit: () {},
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: CommonText(
                                          text: "Custom Offer",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    10.height,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Messages Section
                      /// Messages Section
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.isMoreLoading
                            ? controller.messages.length + 1
                            : controller.messages.length,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemBuilder: (context, index) {
                          if (index < controller.messages.length) {
                            ChatMessageModel message =
                                controller.messages[index];
                            print("image : " + message.image);
                            return ChatBubbleMessage(
                              index: index,
                              image: message.image,
                              time: message.time,
                              text: message.text,
                              messageImage:
                                  message.messageImage, // Add this line
                              isMe: message.isMe,
                              isUploading: message.isUploading, // Add this line
                              onTap: () {},
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),

          /// Bottom Navigation Bar
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).padding.bottom + 16.h,
              top: 16.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: TextField(
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: "Write your message",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: _showAttachmentOptions,
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              Icons.attach_file,
                              color: Colors.grey[600],
                              size: 22.sp,
                            ),
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      onSubmitted: (p0) => controller.addNewMessage(),
                    ),
                  ),
                ),
                12.width,
                GestureDetector(
                  onTap: controller.addNewMessage,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.send, color: Colors.white, size: 20.sp),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
