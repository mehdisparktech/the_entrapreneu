import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/chat_list_model.dart';
import '../../repository/chat_repository.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/enum/enum.dart';

class ChatController extends GetxController {
  /// Chat List here
  List<ChatModel> chats = [];

  /// Chat Loading Bar
  bool isLoading = false;

  /// Chat more Data Loading Bar
  bool isLoadingMore = false;

  /// No more chat data
  bool hasNoData = false;

  /// page no here
  int page = 0;

  /// Chat Scroll Controller
  ScrollController scrollController = ScrollController();

  /// Chat Controller Instance create here
  static ChatController get instance => Get.put(ChatController());

  /// Chat More data Loading function
  void moreChats() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isLoadingMore || hasNoData) return;
        isLoadingMore = true;
        update();
        page++;
        List<ChatModel> list = await chatRepository(page);
        if (list.isEmpty) {
          hasNoData = true;
        } else {
          chats.addAll(list);
        }
        isLoadingMore = false;
        update();
      }
    });
  }

  /// Chat data Loading function
  Future<void> getChatRepo() async {
    if (isLoading || hasNoData) return;
    isLoading = true;
    update();

    page++;
    List<ChatModel> list = await chatRepository(page);
    if (list.isEmpty) {
      hasNoData = true;
    } else {
      chats.addAll(list);
    }
    isLoading = false;
    update();
  }

  /// Api status check here
  Status get status {
    if (isLoading && chats.isEmpty) return Status.loading;
    if (chats.isEmpty && hasNoData) return Status.error;
    return Status.completed;
  }

  /// Chat data Update  Socket listener
  listenChat() async {
    SocketServices.on("update-chatlist::${LocalStorage.userId}", (data) {
      page = 0;
      chats.clear();
      hasNoData = false;

      for (var item in data) {
        chats.add(ChatModel.fromJson(item));
      }

      update();
    });
  }

  /// Controller on Init
  @override
  void onInit() {
    super.onInit();
    getChatRepo();
    moreChats();
  }
}
