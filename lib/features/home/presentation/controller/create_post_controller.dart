import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../data/view_data.dart';

class CreatePostController extends GetxController {
  var isLoading = true.obs;
  var isSendingMessage = false.obs;
  Rx<ViewData?> post = Rx<ViewData?>(null);
  String postId = '';
  TextEditingController messageController = TextEditingController();
  String serviceId = '';

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments ?? '';
    if (postId.isNotEmpty) {
      loadPostDetails();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  Future<void> loadPostDetails() async {
    isLoading.value = true;

    try {
      final response = await ApiService.get('/posts/$postId');

      if (response.statusCode == 200) {
        final viewPostResponse = ViewPostResponseModel.fromJson(response.data);
        post.value = viewPostResponse.data;
        serviceId = response.data["data"]["_id"];
        print("service id 😍😍😍😍 $serviceId");
      }
    } catch (e) {
      print('Error fetching post details: $e');
      Get.snackbar(
        'Error',
        'Failed to load post details',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createChatRoom() async {
    if (post.value?.user.id == null) {
      Get.snackbar(
        'Error',
        'User information not available',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSendingMessage.value = true;

    try {
      // Create chat room with other user's ID
      final response = await ApiService.post(
        '/chat/room/${post.value!.user.id}',
      );

      if (response.statusCode == 200 && response.data != null) {
        final chatRoomId = response.data['data']['_id'];
        print("kldfjdkfj 😍😍😍😍$chatRoomId");
        print("service id : 😂😂😂😂 $serviceId");
        // Navigate to message screen with chat room ID
        Get.toNamed(
          AppRoutes.firstMessageScreen,
          arguments: {
            'chatRoomId': chatRoomId,
            'otherUserId': post.value!.user.id,
            'otherUserName': post.value!.user.name,
            'initialMessage': messageController.text.trim(),
            'serviceId': serviceId,
          },
        );

        // Clear message controller
        messageController.clear();
      } else {
        Get.snackbar(
          'Error',
          'Failed to create chat room',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error creating chat room: $e');
      Get.snackbar(
        'Error',
        'Failed to start conversation. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSendingMessage.value = false;
    }
  }

  String getFormattedDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String getTimeAgo(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      Duration difference = DateTime.now().difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }

  void startConversation() {
    Get.snackbar(
      'Conversation',
      'Starting conversation with ${post.value?.user.name}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
