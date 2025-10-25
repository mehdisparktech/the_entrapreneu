import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class ChatController extends GetxController {
  /// Api status check here
  Status status = Status.completed;

  /// Chat more Data Loading Bar
  bool isMoreLoading = false;

  /// page no here
  int page = 1;

  /// Chat List here
  List chats = [];

  /// Chat Scroll Controller
  ScrollController scrollController = ScrollController();

  /// Chat Controller Instance create here
  static ChatController get instance => Get.put(ChatController());

  /// Chat More data Loading function
  Future<void> moreChats() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await getChatRepo();
      isMoreLoading = false;
      update();
    }
  }

  /// Chat data Loading function
  Future<void> getChatRepo() async {
    // Add demo chat data for testing
    if (page == 1) {
      status = Status.loading;
      update();

      // Add demo chat list
      chats.addAll([
        ChatModel(
          id: '1',
          participant: Participant(
            id: '101',
            fullName: 'Sarah Johnson',
            image: 'https://randomuser.me/api/portraits/women/44.jpg',
          ),
          latestMessage: LatestMessage(
            id: 'm1',
            message: 'Hey there! How are you doing?',
            createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
          ),
        ),
        ChatModel(
          id: '2',
          participant: Participant(
            id: '102',
            fullName: 'Alex Chen',
            image: 'https://randomuser.me/api/portraits/men/32.jpg',
          ),
          latestMessage: LatestMessage(
            id: 'm2',
            message: 'Can we reschedule our meeting to tomorrow?',
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ),
        ChatModel(
          id: '3',
          participant: Participant(
            id: '103',
            fullName: 'Tech Support',
            image: 'https://randomuser.me/api/portraits/lego/5.jpg',
          ),
          latestMessage: LatestMessage(
            id: 'm3',
            message: 'Your support ticket #4567 has been resolved.',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ),
        ChatModel(
          id: '4',
          participant: Participant(
            id: '104',
            fullName: 'David Wilson',
            image: 'https://randomuser.me/api/portraits/men/75.jpg',
          ),
          latestMessage: LatestMessage(
            id: 'm4',
            message: 'Thanks for your help with the project!',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ),
        ChatModel(
          id: '5',
          participant: Participant(
            id: '105',
            fullName: 'Team Standup',
            image: 'https://randomuser.me/api/portraits/lego/2.jpg',
          ),
          latestMessage: LatestMessage(
            id: 'm5',
            message: 'Meeting at 3 PM today. Don\'t forget!',
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
          ),
        ),
      ]);

      status = Status.completed;
      update();
      return;
    }

    var response = await ApiService.get("${ApiEndPoint.chats}?page=$page");

    if (response.statusCode == 200) {
      var data = response.data['chats'] ?? [];

      for (var item in data) {
        chats.add(ChatModel.fromJson(item));
      }

      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  /// Chat data Update  Socket listener
  listenChat() async {
    SocketServices.on("update-chatlist::${LocalStorage.userId}", (data) {
      page = 1;
      chats.clear();

      for (var item in data) {
        chats.add(ChatModel.fromJson(item));
      }

      status = Status.completed;
      update();
    });
  }

  /// Controller on Init¬
  @override
  void onInit() {
    getChatRepo();
    super.onInit();
  }
}
