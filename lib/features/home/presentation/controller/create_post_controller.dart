import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../services/api/api_service.dart';
import '../../data/view_data.dart';

class CreatePostController extends GetxController {
  var isLoading = true.obs;
  Rx<ViewData?> post = Rx<ViewData?>(null);
  String postId = '';

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments ?? '';
    if (postId.isNotEmpty) {
      loadPostDetails();
    }
  }

  Future<void> loadPostDetails() async {
    isLoading.value = true;

    try {
      final response = await ApiService.get('/posts/$postId');

      if (response.statusCode == 200 && response.data != null) {
        final viewPostResponse = ViewPostResponseModel.fromJson(response.data);
        post.value = viewPostResponse.data;
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