import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../controller/post_controller.dart';
import '../widgets/my_post.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPostController controller = Get.put(MyPostController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Post"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.posts.isEmpty) {
          return const Center(
            child: Text("No posts found"),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: controller.posts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                var post = controller.posts[index];
                return PostCard(
                  postData: post,
                  onTap: () {
                    Get.toNamed(AppRoutes.createPost, arguments: post.id);
                  },
                  onDelete: (postId) {
                    controller.deletePost(postId);
                  },
                  onEdit: (postId) {
                    Get.toNamed(AppRoutes.editPost, arguments: post.id);
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}