import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import '../../../../../../config/route/app_routes.dart';
import '../../../../component/other_widgets/common_loader.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../controller/chat_controller.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../../../utils/enum/enum.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widgets/chat_list_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section Starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.inbox,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),

      /// Body Section Starts here
      body: GetBuilder<ChatController>(
        builder: (controller) => switch (controller.status) {
          /// Loading bar here
          Status.loading => const CommonLoader(),

          /// Error Handle here
          // Status.error => ErrorScreen(
          //   onTap: ChatController.instance.getChatRepo,
          // ),
          Status.error => SizedBox(
            height: Get.height,
            width: Get.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonImage(
                    imageSrc: "assets/images/noData.png",
                    height: 100.h,
                    width: 100.w,
                  ),
                  SizedBox(height: 20.h),
                  CommonText(
                    text: "No Chat List Found",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),

          /// Show main data here
          Status.completed => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                /// User Search bar here
                CommonTextField(
                  prefixIcon: const Icon(Icons.search),
                  hintText: AppString.searchDoctor,
                ),

                /// Show all Chat List here
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.chats.length,
                    padding: EdgeInsets.only(top: 16.h),
                    itemBuilder: (context, index) {
                      ChatModel item = controller.chats[index];
                      return GestureDetector(
                        /// routing with data
                        onTap: () => Get.toNamed(
                          AppRoutes.message,
                          parameters: {
                            "chatId": item.id,
                            "name": item.participant.fullName,
                            "image": item.participant.image,
                          },
                        ),

                        /// Chat List item here
                        child: chatListItem(item: controller.chats[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        },
      ),
    );
  }
}
