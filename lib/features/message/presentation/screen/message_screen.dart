import 'package:flutter/material.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../data/model/chat_message_model.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/message_controller.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widgets/chat_bubble_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";

  @override
  void initState() {
    MessageController.instance.name = name;
    MessageController.instance.chatId = chatId;
    MessageController.instance.getMessageRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        return Scaffold(
          /// App Bar Section starts here
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: 20.sp,
              ),
              onPressed: () => Get.back(),
            ),
            title: Row(
              children: [
                /// participant image here
                CircleAvatar(
                  radius: 18.sp,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: CommonImage(imageSrc: image, size: 36),
                  ),
                ),
                12.width,

                /// participant Name and Status here
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: name,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                    CommonText(
                      text: "ACTIVE NOW",
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Body Section starts here
          body: controller.isLoading
              /// Loading bar here
              ? const Center(child: CircularProgressIndicator())
              /// Show data  here
              : ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(12.h),
                  controller: controller.scrollController,
                  itemCount: controller.isMoreLoading
                      ? controller.messages.length + 1
                      : controller.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    /// Message item here
                    if (index < controller.messages.length) {
                      ChatMessageModel message = controller.messages[index];
                      return ChatBubbleMessage(
                        index: index,
                        image: message.image,
                        time: message.time,
                        text: message.text,
                        isMe: message.isMe,
                        name: name,
                        onTap: () {},
                      );
                    } else {
                      /// More data loading bar
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),

          /// bottom Navigation Bar Section starts here
          bottomNavigationBar: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),

              /// Send message text filed here
              child: CommonTextField(
                hintText: AppString.messageHere,
                suffixIcon: GestureDetector(
                  onTap: controller.addNewMessage,
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: const Icon(Icons.send),
                  ),
                ),
                borderColor: Colors.white,
                borderRadius: 8,
                controller: controller.messageController,
                onSubmitted: (p0) => controller.addNewMessage(),
              ),
            ),
          ),
        );
      },
    );
  }
}
