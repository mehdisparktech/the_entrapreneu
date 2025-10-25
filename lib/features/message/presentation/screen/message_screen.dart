import 'package:flutter/material.dart';
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
            leading: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// participant image here
                  CircleAvatar(
                    radius: 30.sp,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: CommonImage(imageSrc: image, size: 60),
                    ),
                  ),
                  12.width,

                  /// participant Name here
                  CommonText(
                    text: name,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
            leadingWidth: Get.width,
          ),

          /// Body Section starts here
          body:
              controller.isLoading
                  /// Loading bar here
                  ? const Center(child: CircularProgressIndicator())
                  /// Show data  here
                  : ListView.builder(
                    reverse: true,
                    controller: controller.scrollController,
                    itemCount:
                        controller.isMoreLoading
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
