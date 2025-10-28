import 'package:get/get.dart';
import 'package:the_entrapreneu/config/api/api_end_point.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../data/data_model.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  List<Post> allPosts = [];
  List<Post> filteredPosts = [];
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    update();

    try {
      final response = await ApiService.get(
        ApiEndPoint.post,
        header: {
          "Authorization": "Bearer ${LocalStorage.token}",
        },
      ); // Replace with your actual endpoint

      if (response.statusCode == 200 && response.data != null) {
        final postResponse = PostResponseModel.fromJson(response.data);
        allPosts = postResponse.data;
        filteredPosts = allPosts;
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void searchPosts(String query) {
    searchQuery = query.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredPosts = allPosts;
    } else {
      filteredPosts = allPosts.where((post) {
        return post.title.toLowerCase().contains(searchQuery) ||
            post.description.toLowerCase().contains(searchQuery) ||
            post.user.name.toLowerCase().contains(searchQuery);
      }).toList();
    }

    update();
  }

  void clearSearch() {
    searchQuery = '';
    filteredPosts = allPosts;
    update();
  }
}