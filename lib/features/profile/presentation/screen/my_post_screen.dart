import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/app_bar/custom_appbar.dart';
import 'package:the_entrapreneu/features/profile/presentation/widgets/my_post.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';

import '../../../../component/button/common_button.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../home/presentation/widgets/home_items.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              return PostCard(onTap: (){
                Get.toNamed(AppRoutes.createPost);
              });
            },
          ),
        ),
      ),
    );
  }
  static void confirmDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to Complete This Order?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Added spacing
            children: [
              Expanded(
                // Added to prevent overflow
                child: CommonButton(
                  titleText: "No",
                  buttonColor: AppColors.grey,
                  titleColor: Colors.black,
                  onTap: () => Get.back(),
                ),
              ),
              const SizedBox(width: 8), // Added spacing between buttons
              Expanded(
                // Added to prevent overflow
                child: CommonButton(
                  titleText: "Yes",
                  buttonColor: AppColors.red,
                  titleColor: Colors.white,
                  onTap: () {
                    Get.toNamed(AppRoutes.reviewScreen);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
