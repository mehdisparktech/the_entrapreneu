import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/features/home/presentation/controller/home_controller.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';

import '../../../../services/api/api_response_model.dart';
import '../../../../services/api/api_service.dart';
import '../../data/post_model.dart';

class MyPostController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<MyPostsModel?> myPostsModel = Rx<MyPostsModel?>(null);
  RxList<PostData> posts = <PostData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyPosts();
  }

  Future<void> fetchMyPosts() async {
    try {
      isLoading.value = true;

      ApiResponseModel response = await ApiService.get(
        'posts/my-post',
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}', // Add your token here
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        myPostsModel.value = MyPostsModel.fromJson(response.data);
        posts.value = myPostsModel.value?.data ?? [];
      }
    } catch (e) {
      print('Error fetching posts: $e');
      Get.snackbar(
        'Error',
        'Failed to load posts',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      ApiResponseModel response = await ApiService.delete(
        'posts/$postId',
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}', // Add your token here
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Remove post from list
        posts.removeWhere((post) => post.id == postId);
        Get.snackbar(
          'Success',
          'Post deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.find<HomeController>().fetchPosts();
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete post',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error deleting post: $e');
      Get.snackbar(
        'Error',
        'Failed to delete post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Helper method to get pagination info
  Pagination? get pagination => myPostsModel.value?.pagination;
}